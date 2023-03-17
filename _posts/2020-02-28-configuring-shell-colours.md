---
title: Configuring shell colours
layout: post
---

Whilst moving my development environment to WSL2, I noticed that the
default shell colours for listing files made the text hard to read due
to poor contrast. So I went about finding a way to change those
defaults.

<!--kg-card-begin: markdown-->

> This guide assumes you\'re using Linux (whether directly or through
> WSL) or MacOS.

<!--kg-card-end: markdown-->

First let\'s look at our current output of `ls -la`.

<figure class="kg-card kg-image-card" markdown="1">
![Output of ls -la command shows directories have a blue
colour](/content/images/2020/02/image-1.png){: .kg-image}
</figure>

Here we can see the `.oh-my-zsh` directory is presented in blue, while
the file `.profile` is in white.

### LS_COLORS {#ls_colors}

The `ls` program reads from the `LS_COLORS` variable to determine how
the filenames will be displayed in the terminal. This variable can be
set using the `dircolors` program. You can read more about it on it\'s
[man page][1].

<!--kg-card-begin: markdown-->

The LS_COLORS variable can be set directly, but for the purpose of this
guide we\'ll be using `dircolors`. Here\'s a [solution][2] for achieving
that.

<!--kg-card-end: markdown-->

### dircolors program {#dircolors-program}

Let\'s see what our current settings look like.

```bash
dircolors -p
```

This should give us an output of all the settings. The `-p` option is an
alias for `--print-database`.

<figure class="kg-card kg-image-card" markdown="1">
![Output of running the dircolors -p
command](/content/images/2020/02/image.png){: .kg-image}
</figure>

You should see an output similar to the above. This is our default
configuration.

### Creating our config file {#creating-our-config-file}

If we want to create a config of our own, we can save this output to a
file and make our changes.

```bash
dircolors -p > $HOME/.dircolors
```

We\'re saving the output to a file called `.dircolors` in our home
directory. You can save yours in whatever location you prefer.

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

<figure class="kg-card kg-image-card" markdown="1">
![Close up of comments describing colour code
definitions](/content/images/2020/02/image-2.png){: .kg-image}
</figure>

If we want to set the colour for a directory to red, first we find the
existing statement and make our changes. In my case it\'s set to blue.

```bash
DIR 01;34
```

Let\'s change the blue to red.

```bash
DIR 01;31
```

And if we wanted to add a white background, we\'d do the following.

```bash
DIR 01;31;47
```

The syntax represents the following entities separated by a semi-colon
in the following order.

- `DIR` - we\'re setting a color for directories
- `01` - the **attribute** code, in this case we\'ll make it bold
- `31` - the **text color** code, which is set to red
- `47` - the **background color** code, which is set to white

Let\'s load our new config by using the `source` program.

```bash
source ~/.zshrc
```

When we now run `ls -la` the colour of `.oh-my-zsh` should have now
changed.

<figure class="kg-card kg-image-card" markdown="1">
![Output of ls -la command shows directories have a white background
with red text](/content/images/2020/02/image-3.png){: .kg-image}
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
