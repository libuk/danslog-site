---
title: Reviewing code as a junior engineer
---

Over the last few years, we\'ve seen an influx of junior engineers in
the tech industry. A lot of advice has been given regarding interviewing
for a first role, but I want to touch on something that I don\'t see
talked about that often; reviewing code as a junior engineer.

When I was a junior, it was difficult enough getting my own code to work
so I definitely understand the fear of being dropped into a new codebase
as someone just starting out. I do think, however, that my experience
could have been made easier had I received more guidance on the
importance of peer review.

### Learning how to deal with criticism   {#learning-how-to-deal-with-criticism}

As a junior, I was very protective over my code. I consider myself to be
a perfectionist, which roughly translates to \"making mistakes scares
the shit out of me\". I would analyse code over and over again, trying
to put off the inevitable opening of a pull request, desperately trying
to ensure there were no issues that anybody could point out. But there
**were** issues, there were almost always issues. And it\'s to be
expected as I was starting out, still learning the codebase and even the
syntax of the language (JavaScript). And that\'s to say nothing of
trying to understand the actual business value of the feature/bugfix I
was working on.

The feeling is understandable, but if you\'re in the right team, code
reviews can be a great environment for levelling up. Try to remember
that you are not the code you write. It isn\'t easy, and when people
point out your mistakes to you it may take a while until you stop
feeling that sting of frustration. But try to keep a healthy
perspective, this is the path of the engineer and the more distance you
can put between your ego and your code, the quicker you\'ll see the
value of getting more eyes reviewing your work.

Now, I wouldn\'t be doing you justice if I made code reviews out to
always be an earnest pursuit of improving code quality. Depending on
your team, code reviews can also be a place where team members can be
overly critical, or even use it as an opportunity to embarrass you;
minorities in tech know this feeling all too well. Unfortunately, you
should be ready for that too. But try your best to keep discussions
solely about the code, because again, you aren\'t the code you write,
even if someone tries to make it so.

### Improving technical communication   {#improving-technical-communication}

Technical communication is one of the most important skills as an
engineer. Being able to efficiently communicate with other engineers is
a skill that will take time, and to efficiently communicate with
non-technical peers even longer. But sticking to the technical side of
things, be sure that you\'re adding to your technical vocabulary. As a
junior, there\'d be times when I\'d finish explaining an approach, only
for a colleague to sum up my whole dialogue with a term I\'d never heard
before. Using the correct technical terms, improves the efficiency of
communication.

Take notice in these moments and be sure to write down the term to
research later. Likewise, if you observe a conversation happening
between other engineers, note down any unfamiliar terms they use so you
can research later, or better yet, ask the question. Code reviews are a
great forum to improve your technical communication.

### Use your experience as the measuring stick   {#use-your-experience-as-the-measuring-stick}

Ultimately, we write code for other engineers to understand and
maintain. This means that the harder a codebase is to understand,the
harder it is for engineers to maintain. The harder the codebase is to
maintain, the harder it will be for a company to retain engineers. Try
to use this to your advantage when reviewing code from more senior
developers. The reality is you may not be familiar with many design
patterns or language features, so if you see something you don\'t
understand it\'s easy to put it down to your lack of experience. While
this is true in many cases, keep in mind that it\'s in the best interest
of everyone that code is easily readable and understood by all engineers
on the team.

That may mean you have some learning to do, which is helpful for you as
it gives you something concrete to research, but it also could mean that
the code is unnecessarily complex and that there could be a more
straight forward way of achieving the same result. This is why it\'s
important for you to ask questions when you\'re unsure of something.
There will be times when the author will realise a piece of code could
be written clearer, and this is good news for everyone.

### Isolate code you don\'t understand   {#isolate-code-you-don-t-understand}

When reviewing code you\'ll sometimes find syntax that looks unfamiliar.
I made the point earlier that you should ask questions when you\'re
unsure about something, but asking the question doesn\'t mean that you
can\'t be the one to answer it. Sometimes it helps to copy that piece of
code and run it in an isolated environment, such as a [REPL][1]{:
rel="nofollow"}, for you to poke around and try to understand what it\'s
doing. Ask yourself more questions; what happens if I pass in an object
instead of an array? How does this function behave when nothing is
passed in? You\'ll be surprised where some of these questions will take
you.

Alternatively, you can pull the branch down to your local machine and
run the code yourself, logging values and debugging in the browser. If
you\'re feeling very curious, step through the code using a
[debugger][2]{: rel="nofollow"}.

### Conclusion   {#conclusion}

Reviewing code as a junior can be daunting at first, but it should be
embraced as a way of accelerating your growth as an engineer. Pay
attention to the discussions being had in code reviews, and use your
curiosity to discover new things.



[1]: https://babeljs.io/repl/
[2]: https://developers.google.com/web/tools/chrome-devtools/javascript/
