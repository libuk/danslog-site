---
title: Configuring shell colours
layout: post
---

Whilst moving my development environment to WSL2, I noticed that the
default shell colours for listing files made the text hard to read due
to poor contrast. So I went about finding a way to change those
defaults.

> This guide assumes you\'re using Linux (whether directly or virtually, like WSL2).

First let\'s look at our current output of `ls -la`.

<figure markdown="1">
![](/assets/images/directory_yellow_black.jpg){: .kg-image}
<figcaption>
Output of ls -la command shows directories have a yellow background with black text.
</figcaption>
</figure>

Here we can see the `a_directory` directory is presented with a yellow and background and black text.

### LS_COLORS {#ls_colors}

The `ls` program reads from the `LS_COLORS` variable to determine how
the filenames will be displayed in the terminal. This variable can be
set using the `dircolors` program. You can read more about it on it\'s
[man page][1].

The `LS_COLORS` variable can be set directly, but for the purpose of this
guide we\'ll be using `dircolors`. Here's a [solution][2] for using `LS_COLORS` directly.

### Creating our dircolors config file {#creating-our-dircolors-config-file}

We can save the output of the `dircolors` program to create a config file.

```bash
dircolors -p > $HOME/.dircolors
```

We call run the `dircolors` program with the `-p` flag which is short for `--print-database`. This will give us a list of currently configured settings, and we write the output to our config file `.dircolors`.

Here we save the file in our home directory, but you can save yours in whatever location you prefer.

We want our shell to load our new config instead of loading the default.
Let\'s add some code to our `.bashrc` (or `.zshrc` if you\'re using zsh
like I am) that will run on startup.

```bash
# dircolors - load config for ls colors

dircolors_config=$HOME/.dircolors
test -r $dircolors_config && eval "$(dircolors $dircolors_config)"
```

This snippet checks for the existance of a file `.dircolors` in the home
directory, be sure to point yours to the location you saved it if you
chose another location. It then passes that file as an argument to the
`dircolors` program which [sets][3] the `LS_COLORS` variable.

### Setting colours {#setting-colours}

Open the `.dircolors` file in your preferred text editor. We have a some
comments describing each section and we can see some colour code
definitions we can use to customise it ourselves.

<figure markdown="1">
![](/assets/images/dir_colors_definitions.jpg){: .kg-image}
<figcaption>
screenshot of the dircolors program colour code definitions.
</figcaption>
</figure>

If we want to set the background colour for a directory to white, first we find the
existing statement and make our changes. In my case it's set to yellow.

```bash
DIR 30;43
```

Let\'s change the background from yellow to white.

```bash
DIR 30;47
```

And the text colour from black to red

```bash
DIR 31;47
```

The syntax represents the following entities separated by a semi-colon
in the following order.

- `DIR` - we\'re setting a color for directories
- `31` - the **text color** code, which is set to red
- `47` - the **background color** code, which is set to white

Let\'s load our new config by using the `source` program.

```bash
source ~/.zshrc
```

When we now run `ls -la` the colour of directories should have now
changed.

<figure markdown="1">
![](/assets/images/directory_white_red.jpg){: .kg-image}
<figcaption>
Output of ls -la command shows directories have a white background with red text
</figcaption>
</figure>

There we have it! How to customise the output of `ls` without any extra
tools or themes. Experiment and customise to your heart\'s content.

### Resources {#resources}

- `dircolors` source code -
  [https://github.com/coreutils/coreutils/blob/master/src/dircolors.c][4]
- `dircolors` man page - [https://linux.die.net/man/5/dir_colors][1]

[1]: https://linux.die.net/man/5/dir_colors
[2]: https://askubuntu.com/questions/466198/how-do-i-change-the-color-for-directories-with-ls-in-the-console
[3]: https://github.com/coreutils/coreutils/blob/05a99f7d7f8e0999994b760bb6337ca10ea0a14b/src/dircolors.c#L494
[4]: https://github.com/coreutils/coreutils/blob/master/src/dircolors.c
