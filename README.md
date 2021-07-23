# dotfiles

This is my script for setting up my development environment. You can use it yourself, too. It won't bite!

I've tried to make the default setup as non-custom as possible while still providing sensible defaults for developers.

But, of course, a lot of this still caters to my tastes. :)

## Installation

Pick master or bissell:

Master: `git clone -b master git@github.com:kibiz0r/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./install`
BISSELL: `git clone -b bissell git@github.com:kibiz0r/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./install`

If you want the kibiyama awesomesauce, run `./install_plus_kibiyama` instead of `./install`.

## Customization

You can layer your own stuff on top of the base stuff. If you use the kibiyama stuff, your stuff will be run last so you don't get overwritten.

To understand what's going on, look at `install.conf.yaml`.

There are some environment variables you can change to tailor the installation to your environment.

```
USE_VSCODE_INSIDERS to use bleeding-edge VSCode
USE_SUDO to do full setup rather than non-admin captive setup
USE_HOME_APPDIR to cheat and install apps to ~/Applications (mainly to avoid getting admin permissions to run stuff)
USE_HOME_HOMEBREW to install Homebrew to ~/homebrew... Try not to use this one if you can help it
USE_KIBIYAMA_CUSTOMIZATIONS to use my custom configs
```

The default setup is rather idealistic and safe. It uses stable VSCode, avoids sudo, installs to global /Applications, installs Homebrew normally, and doesn't use my custom stuff.

## TODO

- defaults write com.apple.dock autohide-delay 31536000 && killall Dock # but need autohide toggle shortcut on cmd+shift+d
- brew cask install java before installing first round of brews; sleuthkit depends on it, osquery depends on sleuthkit
- brew cask install xquartz too; feh requires it
- ./per_user_host: line 15: ./write_defaults.kibiyama: No such file or directory
- ./per_user_host: line 15: ./install_app_store_apps.kibiyama: No such file or directory
- phantomjs is a cask now
- Requested 'libusbmuxd >= 1.1.0' but version of libusbmuxd is 1.0.10 -- from installing libimobiledevice
- sudo xcodebuild -license accept
- "Opening Dropbox and waiting for /Users/kibiyama/Dropbox/license.dash-license in background"; but "The file /Applications/Dropbox.app does not exist."
- Be quieter when unzipping
- Roslynator.VisualStudio.vsix; End-of-central-directory signature not found
- mysides is not installed; when running ./configure_finder_favorites.kibiyama
- File Doesn't Exist, Will Create: /Users/kibiyama/Library/Preferences/com.apple.controlstrip.plist
  Delete: Entry, ":MiniCustomized", Does Not Exist
  Maybe configuring kibiyama's Spotlight [./require_kibiyama ./configure_spotlight]
  Delete: Entry, ":orderedItems", Does Not Exist
- rm: /Users/kibiyama/Library/LaunchAgents/com.kibiz0r.sync_music.plist: No such file or directory; after ./configure_linked_preferences
- make killall NotificationCenter have a `; exit 0` on it
- Chrome extensions
- Caps Lock => Esc
- iTerm should already know to check for updates automatically
- Start BetterTouchTool on start-up
- hide_spotlight_icon breaks Spotlight completely on Mojave
