my dotfiles
===================

Requirements
------------

Currently using bash as shell:

`chsh -s $(which bash)`

Install
-------

Clone onto your laptop:

1. `git clone git@github.com:mcritchlow/dotfiles.git`
2. Install [rcm](https://github.com/thoughtbot/rcm):
3. Install the dotfiles: `env RCRC=$HOME/dotfiles/rcrc rcup`

This command will create symlinks for config files in your home directory.
Setting the `RCRC` environment variable tells `rcup` to use standard
configuration options:

You can safely run `rcup` multiple times to update:

Thanks
------

To thoughtbot and the [original contributors](https://github.com/thoughtbot/dotfiles/contributors). I've modified this
heavily and don't use Mac OS anymore, but still use RCM and much of the original ideas. Thanks!
