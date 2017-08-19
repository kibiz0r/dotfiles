# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.zsh_custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME=$USER.$HOST
if [ ! -f $ZSH_CUSTOM/themes/$ZSH_THEME.zsh-theme ]; then
  ZSH_THEME="kibiyama.hekapoo.local"
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

# User configuration

export PATH="$PATH:$HOME/bin"
export EDITOR="mvim -f"

# Prevent IOException: kqueue() FileSystemWatcher has reached the maximum nunmber of files to watch.
export MONO_MANAGED_WATCHER=false

# Android Studio SDK
export ANDROID_HOME=/usr/local/opt/android-sdk
export PATH=$PATH:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools

function docker-start() {
  docker-machine start default 
  eval "$(docker-machine env --shell=zsh default)"
}

function docker-shell() {
  docker run -it $1 /bin/bash
}

alias be='bundle exec'
alias git=hub

alias cd-garten="cd ~/git/kindergarten"
alias cd-kin="cd ~/git/kin"
alias cd-proto="cd ~/git/yeti-prototypes"
alias cd-example="cd ~/git/kindergarten/Examples/SensorAPIWithWikitude"
alias cd-panion="cd ~/git/yeti-prototypes/Kinpanion"
