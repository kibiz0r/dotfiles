# Might need this?
# eval $(/usr/libexec/path_helper)

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.zsh_custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
USER_HOST=$USER.`hostname | sed s/\.local//`
if [ -f $ZSH_CUSTOM/themes/$USER_HOST.zsh-theme ]; then
  ZSH_THEME=$USER_HOST
elif [ -f $ZSH_CUSTOM/themes/$USER.zsh-theme ]; then
  ZSH_THEME=$USER
else
  ZSH_THEME="kibiyama"
fi

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Automatically approve of updates without prompt
export DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
  alias rubies="rbenv install -l"
fi

# User configuration
export PATH="$PATH:$HOME/bin:$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$HOME/.dotnet/tools"
export EDITOR="mvim -f"
export PAGER="tabless"
export LESS="-Ri"

alias less=$PAGER

# Android Studio SDK
# export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools

# My stuff
alias be='bundle exec'
alias git=hub
alias mvim='/usr/local/bin/mvim $@ > /dev/null 2>&1'
alias dot="cd $HOME/.dotfiles"
alias reddit="RTV_BROWSER=lynx rtv --enable-media"
alias csharp="$(command which csharp) -r:System.Reactive.Core,System.Reactive.Linq,System.Reactive.Interfaces -r:System.Net.Http -r:$HOME/.nuget/packages/newtonsoft.json/12.0.2/lib/net45/Newtonsoft.Json.dll"

alias bis="cd $HOME/git/BISSELL_Xamarin_App"
alias bisd="cd $HOME/git/BISSELL_Xamarin_App_Develop"
alias bisr="cd $HOME/git/BISSELL_Xamarin_App_Release"
alias bisp="cd $HOME/git/BISSELL_Xamarin_App_PR"
alias bispr="cd $HOME/git/BISSELL_Xamarin_App_PR"
alias bisdrs="cd $HOME/git/BISSELL_Xamarin_App_DRS"
alias ota="cd $HOME/git/OTATool"
alias wiki="cd $HOME/git/TroubleshootingWiki"

# Hackintosh
alias esp_internal="$HOME/.dotfiles/hackintosh/mount_internal"
alias esp_usb="$HOME/.dotfiles/hackintosh/mount_usb"

# NOTE: Mono bugs
# Prevent IOException: kqueue() FileSystemWatcher has reached the maximum nunmber of files to watch.
export MONO_MANAGED_WATCHER=false
# https://github.com/dotnet/netcorecli-fsc/wiki/.NET-Core-SDK-1.0#using-net-framework-as-targets-framework-the-osxunix-build-fails
# https://github.com/dotnet/sdk/issues/335
export FrameworkPathOverride=$(dirname $(which mono))/../lib/mono/4.5/

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/usr/local/opt/qt/bin:$PATH"
