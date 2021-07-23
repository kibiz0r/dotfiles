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
export EDITOR="code -n --wait"
# export EDITOR="mvim -f"
# export PAGER="tabless"
export LESS="-Ri"

# alias less=$PAGER

# Android Studio SDK
# export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools
export NODE_PATH=/usr/local/lib/node_modules

# My stuff
alias be='bundle exec'
alias git=hub
alias mvim='/usr/local/bin/mvim $@ > /dev/null 2>&1'
alias dot="cd $HOME/.dotfiles"
alias reddit="RTV_BROWSER=lynx rtv --enable-media"
alias csharp="$(command which csharp) -r:System.Reactive.Core,System.Reactive.Linq,System.Reactive.Interfaces -r:System.Net.Http -r:$HOME/.nuget/packages/newtonsoft.json/12.0.2/lib/net45/Newtonsoft.Json.dll -r:$HOME/.nuget/packages/yamldotnet/8.1.2/lib/net45/YamlDotNet.dll"
alias meme="node --no-warnings $HOME/.dotfiles/node_modules/.bin/meme"
alias memes="cat /usr/local/lib/node_modules/memey/data/memes.json | jq '.[].name' | sort"

memecat() {
  local memeout=$( meme $@ )
  if [[ $memeout == '' ]]; then
    echo "Meme not found."
    return 1
  fi
  if echo $memeout | grep "not found" > /dev/null 2>&1; then
    echo $memeout
    return 1
  fi
  local memeurl=$( echo $memeout | rev | cut -d ' ' -f1 | rev )
  curl -s $memeurl | imgcat
}

epoch() {
  if [[ -z $1 ]]; then
    gdate +%s
  else
    gdate -d @$1
  fi
}

epochms() {
  if [[ -z $1 ]]; then
    echo "$(gdate +%s) * 1000" | bc
  else
    gdate -d @$( echo "($1 + 500) / 1000" | bc )
  fi
}

alias xam="cd $HOME/git/BISSELL_Xamarin_App"
alias xam2="cd $HOME/git/BISSELL_Xamarin_App2"
alias xamd="cd $HOME/git/BISSELL_Xamarin_App_Develop"
alias xamr="cd $HOME/git/BISSELL_Xamarin_App_Release"
alias xamp="cd $HOME/git/BISSELL_Xamarin_App_PR"
alias xampr="cd $HOME/git/BISSELL_Xamarin_App_PR"
alias xamdrs="cd $HOME/git/BISSELL_Xamarin_App_DRS"
alias ota="cd $HOME/git/OTATool"
alias wiki="cd $HOME/git/TroubleshootingWiki"
alias plat="cd $HOME/git/AWS_IoT"
alias wtools="cd $HOME/git/e_common_test_utils/wifi"
alias wifi="cd $HOME/git/d_iot_p488"
alias tobor="cd $HOME/git/d_donnybrook"
alias cdf="cd $HOME/git/cdf-facade"
alias cdff="cd $HOME/git/cdf-facade"
alias cdfi="cd $HOME/git/cdf-infrastructure-bissell"
alias cdfa="cd $HOME/git/cdf-facade/app"
alias cdfm="cd $HOME/git/cdf-facade/packages/mobile-api"
alias cdfp="cd $HOME/git/cdf-facade/packages/pairing"
alias cdfd="cd $HOME/git/cdf-facade/packages/durable-api"
alias cdfs="cd $HOME/git/cdf-facade/packages/system-tests"
alias cdfpa="cd $HOME/git/cdf-facade/packages/portal-api"
alias cdfpu="cd $HOME/git/cdf-facade/packages/portal-ui"
alias ni="npm install"
alias nr="npm run"
alias nrb="npm run build"
alias nrt="npm run test"
alias nrr="npm run reset"
alias pn="pnpm"
alias pni="pnpm install"
alias pnu="rm pnpm-lock.yaml; pnpm update"
alias pnr="pnpm run"
alias pnrb="pnpm run build"
alias pnrt="pnpm run test"
alias aze="AWS_PROFILE=cdf_admin AWS_REGION=us-east-1"
alias cdfe="CONFIG_LOCATION=$HOME/git/cdf-infrastructure-bissell aze"

alias nod="NODE_PATH=$HOME/.dotfiles/node_modules node --interactive --experimental-repl-await --eval=\"const _ = require('lodash'); const async = require('async'); const delay = require('delay'); const inversify = require('inversify'); const faker = require('faker'); const AWS = require('aws-sdk'); const moment = require('moment'); const pem = require('pem');\""
alias ts-nod="NODE_PATH=$HOME/.dotfiles/node_modules ts-node --interactive --eval=\"import _ from 'lodash'; import async from 'async'; import delay from 'delay'; import * as inversify from 'inversify';\""

# Hackintosh
alias esp_internal="$HOME/.dotfiles/hackintosh/mount_internal"
alias esp_usb="$HOME/.dotfiles/hackintosh/mount_usb"

# Docker
# eval $(docker-machine env default)
# export LOCALSTACK_HOST=$(docker-machine ip)

# npm executables
export PATH="$PATH:$HOME/.dotfiles/node_modules/.bin"

# NOTE: Mono bugs
# Prevent IOException: kqueue() FileSystemWatcher has reached the maximum nunmber of files to watch.
export MONO_MANAGED_WATCHER=false
# https://github.com/dotnet/netcorecli-fsc/wiki/.NET-Core-SDK-1.0#using-net-framework-as-targets-framework-the-osxunix-build-fails
# https://github.com/dotnet/sdk/issues/335
export FrameworkPathOverride=$(dirname $(which mono))/../lib/mono/4.5/

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/usr/local/opt/qt/bin:$PATH"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/harrinm/git/AWS_IoT/app/foundation/core/code/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/harrinm/git/AWS_IoT/app/foundation/core/code/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/harrinm/git/AWS_IoT/app/foundation/core/code/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/harrinm/git/AWS_IoT/app/foundation/core/code/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/harrinm/git/AWS_IoT/app/foundation/core/code/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/harrinm/git/AWS_IoT/app/foundation/core/code/node_modules/tabtab/.completions/slss.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
