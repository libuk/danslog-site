---
title: Fetching data from the PayPal API using OAuth 2
permalink: /logs/fetching-data-paypal-api-oauth2
layout: post
---

I recently worked with a non-profit org to streamline how they handled reporting their donation data. Previously, they would manually export data from each payment platform for aggregation. To speed this up, I created a small program which pulled data in from each platform and created a single spreadsheet.

One of the platforms, PayPal, uses OAuth 2 which, if you haven't encountered this before, requires a sort of 'dance' in order to authenticate and get the data.

> To learn more about OAuth 2 to here is [an Introduction to OAuth 2 by Digital Ocean](https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2)

## The "OAuth dance"

You may be used to using a client ID and secret to authenticate requests to an API, OAuth 2 goes a step further and requires you to exchange your credentials (in this case, the ID and secret) for a temporary access token which you then use to make a request to the resource server.

In the case of querying the PayPal API for a report, here's a diagram of how the system I built works:

<figure markdown="1">
![](/assets/images/paypal_api_flowchart.jpg)
<figcaption>
A flowchart of the system for retrieving Paypal data.
</figcaption>
</figure>

First, we retrieve the existing access token stored in the [AWS key management service (KMS)](https://aws.amazon.com/kms/). We then make a request to the resource server for the reporting data, and if we're unauthorised ie our access token has expired, we make a request to the authorisation server for the access token. If successful, we store this access token in AWS KMS for use in future. Note that the access tokens we receive from the auth server have an expiry of around 8 hours, after which, we'll have to request a new access token. Now that we have a valid access token, we can make the request to the resource server for our data.

## Code examples

Here are some truncated examples of how to handle each stage of the process. I'm using JavaScript here, but these concepts can be translated to the language of your choice.

This is the asynchronous function we call to return us the report data. Note that I'm making an assumption if the server responds with a 401 it is due to the token expiry (each token expires after approximately 8 hours).

```js
async function getPaypalData() {
  try {
    const accessToken = await getAccessToken();
    const response = await getReport(accessToken);

    return response;
  } catch (error) {
    if (error.status && error.status === 401) {
      try {
        const newAccessToken = await requestAndUpdateAccessToken();
        const response = await getReport(newAccessToken);
        return response;
      } catch (e) {
        throw e;
      }
    } else {
      throw error;
    }
  }
}
```

Making a call to AWS KMS to retrieve the existing token.

```js
const {
  SecretsManagerClient,
  GetSecretValueCommand
} = require('@aws-sdk/client-secrets-manager');

const client = new SecretsManagerClient({
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  },
  region: 'eu-north-1',
});

const secretName = 'secret-name-for-access-token';

async function getAccessToken() {
  const command = new GetSecretValueCommand({ SecretId: secretName });
  const response = await client.send(command);

  return JSON.parse(response.SecretString).access_token_key_of_your_choice;
}
```

If our access token has expired, we request a new access token and update AWS KMS.

```js
async function requestAndUpdateAccessToken() {
  const newAccessToken = await requestAccessToken();
  await updateAccessToken(newAccessToken);

  return newAccessToken;
}
```

`requestAccessToken`

```js
const fetch = require('node-fetch');
const base64 = require('base-64');

const authUrl = 'https://api-m.paypal.com/v1/oauth2/token';

async function requestAccessToken() {
  const base64IdSecret = base64.encode(
    `${process.env.PAYPAL_CLIENT_ID}:${process.env.PAYPAL_CLIENT_SECRET}`
  );

  const response = await fetch(authUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      Authorization: `Basic ${base64IdSecret}`,
    },
    body: 'grant_type=client_credentials',
  }).json();

  return response.access_token;
}
```

`updateAccessToken`

```js
const {
  SecretsManagerClient,
  PutSecretValueCommand
} = require('@aws-sdk/client-secrets-manager');

// AWS client set up (as seen above)

// ...

async function updateAccessToken(newAccessToken) {
  const command = new PutSecretValueCommand({
    SecretId: secretName,
    SecretString: JSON.stringify({ paypal_access_token: newAccessToken }),
  });

  const response = await client.send(command);

  return response;
}
```

And finally, we can get our report data.

```js
async function getTransactions(fromDate, accessToken) {
  const startDate = fromDate.toISOString();
  const endDate = new Date().toISOString();
  const transactionsUrl = `https://api-m.paypal.com/v1/reporting/transactions?start_date=${startDate}&end_date=${endDate}`;

  const response = await fetch(transactionsUrl, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${accessToken}`,
    },
  });

  if (!response.ok) {
    throw response;
  }

  const transactions = await response.json();

  return transactions;
}
```

## Wrapping up

If you haven't come across OAuth 2 before, hopefully this post gives you an idea of how to go about implementing logic to handle this scenario.

To learn more about OAuth 2 best practices when implementing it for your own API, here's a [draft from the OAuth Working Group](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-security-topics).
