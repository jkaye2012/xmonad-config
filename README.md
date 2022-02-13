# Xmonad configuration

## Requirements

The following are required for this configuration to work properly:

    sudo apt install feh scrot trayer xclip xfce4-power-manager xmobar xscreensaver

## Installation

In order to install this configuration, `stack` is required. [GHCup](https://www.haskell.org/ghcup/) is the best way to install this for most users.

Clone this repository, then install it:

    git clone https://github.com/jkaye2012/xmonad-config.git ~/.xmonad
    cd ~/.xmonad
    git submodule update --init --recursive
    stack install

This will install `xmonad` to `~/.local/bin`. You should ensure that the binaries are on
your `PATH`.

## Keybindings

* `M-S-=`: Screenshot a window or region. Files are saved to ~/Pictures/Screenshots and copied to the clipboard.
