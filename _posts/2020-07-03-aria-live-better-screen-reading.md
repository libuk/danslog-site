---
title: 'TIL: A better screen reading experience with aria-live'
---

Let\'s say we have a button that copies a bit of text somewhere on the
page.

    <button id="copy-btn">Copy text</button>
{: .language-html}

When we click, we change the button text to indicate that the action has
been completed successfully.

    const copyBtn = document.querySelector('#copy-btn');
    
    const changeText = event => {
      event.target.innerHTML = 'Text copied';
      
      setTimeout(() => {
        event.target.innerHTML = 'Copy text';
      }, 2000);
    };
    
    copyBtn.addEventListener('click', changeText);
{: .language-javascript}

For screen readers, this isn\'t a good experience. For example, when
using VoiceOver when we keyboard navigate to the button, the screen
reader calls out \"Copy text, button\" as expected.

<figure class="kg-card kg-image-card kg-card-hascaption" markdown="1">
![](/content/images/2020/07/image.png){: .kg-image}
<figcaption>
A highlighted button that reads 'Copy text'
</figcaption>
</figure>

However, when we activate a click it then reads \"Press Text copied,
button\". It calls it out like a brand new button has appeared and not
that an action has taken place. This can feel disorientating,
particularly to users who have impaired vision and rely on sound.

<figure class="kg-card kg-image-card kg-card-hascaption" markdown="1">
![](/content/images/2020/07/image-1.png){: .kg-image}
<figcaption>
A highlighted button that reads 'Text copied'
</figcaption>
</figure>

To fix this, we can use the `aria-live` attribute, which will indicate
that the element will be updated and that assitive technologies should
alert the user to updates of this element. `aria-live` gets set to a
politeness level, either `polite` or `assertive`.

`aria-live="polite"` - Indicates the update is low priority and will
generally wait until other actions have finished being called out.

`aria-live="assertive"` - Indicates the update is high priority and will
interupt any other actions being called out to give the update.

    <button id="copy-btn" aria-live="assertive">Copy text</button>
{: .language-html}

We\'ll use `assertive` as we want to ensure the user gets instant
feedback that the text has been copied. Now the screen reader calls out
\"Text copied\" when we click; a small change but much easier to
understand what\'s going on.

This is handy to have in your toolkit and there\'s a variety ways it can
be used to improve the screen reading experience.

> Note: This was tested using Safari v13.1.1 using VoiceOver on MacOS
> Mojave v10.14.6. Your experience may vary on different
> browsers/operating systems.

### Further reading   {#further-reading}

* [Aria-live - WAI-ARIA spec][1]
* [Aria-live regions - MDN][2]
* [Aria-live regions demo - Terrill Thompson blog][3]



[1]: https://www.w3.org/TR/wai-aria-1.1/#aria-live
[2]: https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/ARIA_Live_Regions
[3]: https://terrillthompson.com/tests/aria/live-scores.html
