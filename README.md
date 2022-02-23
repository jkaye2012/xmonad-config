# Xmonad configuration

## Requirements

The following are required for this configuration to work properly:

    sudo apt install feh fzf redshift rofi scrot slock trayer xclip xfce4-power-manager xmobar

## Installation

In order to install this configuration, `stack` is required. [GHCup](https://www.haskell.org/ghcup/) is the best way to install this for most users.

Clone this repository, then install it:

    git clone https://github.com/jkaye2012/xmonad-config.git ~/.xmonad
    cd ~/.xmonad
    git submodule update --init --recursive
    ln -s ~/.xmonad/xsessionrc ~/.xsessionrc
    ln -s ~/.xmonad/xinitrc ~/.xinitrc
    ln -s ~/.xmonad/Xresources ~/.Xresources
    sudo cp ~/.xmonad/suspend@.service /etc/systemd/system
    sudo systemctl enable suspend@$USERNAME
    stack install

This will install `xmonad` to `~/.local/bin`. You should ensure that the binaries are on
your `PATH`.

The following utilities require some extra setup:

* `fzf`: See `apt-cache show fzf` for instructions on how to set up keybindings.

I recommend using the `Arc Dark` theme for `rofi` (use `rofi-theme-selector` to easily customize this).

If you're using `gnome-terminal`, you can download and enable the `Nord` theme using [Gogh](https://mayccoll.github.io/Gogh/).

## Keybindings

* `M-<Return>`: Open a Gnome terminal instance.
* `M-S-=`: Screenshot a window or region. Files are saved to ~/Pictures/Screenshots and copied to the clipboard.
* `M-s`: Lock the screen.
* `M-S-s`: Suspend and lock the system.
* `M-;`: Run a program using `rofi`.
* `M-'`: Switch to another window using `rofi`.
* `M-c`: Kill the currently focused window.

Media keys should all function natively.
