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
export PATH="$PATH:$HOME/bin"
export EDITOR="code -n --wait"
# alias less=$PAGER
# export PAGER="tabless"
export LESS="-Ri"

# Java
export JAVA_HOME=/usr/local/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home/

# Android Studio SDK
# export ANDROID_HOME=/usr/local/opt/android-sdk
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH="$PATH:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Node
export NODE_PATH=/usr/local/lib/node_modules

# VSCode
export PATH="$PATH:$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# .NET
# export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="/usr/local/share/dotnet:$PATH"

# Homebrew
export PATH="/usr/local/sbin:$PATH"

# My aliases
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

# epoch() {
#   if [[ -z $1 ]]; then
#     gdate +%s
#   else
#     gdate -d @$1
#   fi
# }

# epochms() {
#   if [[ -z $1 ]]; then
#     echo "$(gdate +%s) * 1000" | bc
#   else
#     gdate -d @$( echo "($1 + 500) / 1000" | bc )
#   fi
# }

# atoken() {
#   local login_response=$( $@ )
#   local token=$( echo $login_response | jq -r .access_token )
#   export ATOKEN=$token
#   echo 'echo $ATOKEN:' $token
# }

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
alias cdfpp="cd $HOME/git/cdf-facade/packages/pairing"
alias cdfd="cd $HOME/git/cdf-facade/packages/durable-api"
alias cdfst="cd $HOME/git/cdf-facade/packages/system-tests"
alias cdfp="cd $HOME/git/cdf-facade/packages/portal-api"
alias cdfpa="cd $HOME/git/cdf-facade/packages/portal-api"
alias cdfpu="cd $HOME/git/cdf-facade/packages/portal-ui"
alias cdfm="cd $HOME/git/cdf-facade/packages/mobile-api"
alias cdfsd="cd $HOME/git/cdf-facade/packages/seed-data"

alias cdf2="cd $HOME/git/cdf-facade2"
alias cdff2="cd $HOME/git/cdf-facade2"
alias cdfi2="cd $HOME/git/cdf-infrastructure-bissell"
alias cdfa2="cd $HOME/git/cdf-facade2/app"
alias cdfp2="cd $HOME/git/cdf-facade2/packages/pairing"
alias cdfd2="cd $HOME/git/cdf-facade2/packages/durable-api"
alias cdfst2="cd $HOME/git/cdf-facade2/packages/system-tests"
alias cdfpa2="cd $HOME/git/cdf-facade2/packages/portal-api"
alias cdfp2u="cd $HOME/git/cdf-facade2/packages/portal-ui"
alias cdfm2="cd $HOME/git/cdf-facade2/packages/mobile-api"
alias cdfsd2="cd $HOME/git/cdf-facade2/packages/seed-data"

alias cdf3="cd $HOME/git/cdf-facade3"

alias mob="cd $HOME/git/MobileFoundations"
alias mob2="cd $HOME/git/MobileFoundations2"

alias ut="cd $HOME/git/udm-tool-expo"

# alias azcdfa="AWS_PROFILE=cdf_admin AWS_REGION=us-east-1"
# alias azcdf="AWS_PROFILE=cdf_dev AWS_REGION=us-east-1"
# alias azdev="AWS_PROFILE=bhidev AWS_REGION=us-east-1"
# alias azsbx="AWS_PROFILE=sbx AWS_REGION=us-east-1"
# alias azuat="AWS_PROFILE=uat AWS_REGION=us-east-1"
# alias azprod="AWS_PROFILE=prod AWS_REGION=us-east-1"

# alias cdfe="CONFIG_LOCATION=$HOME/git/cdf-infrastructure-bissell azcdf"
# alias sbxe="CONFIG_LOCATION=$HOME/git/cdf-infrastructure-bissell azsbx"

here() {
  declare -a args

  for ((i=1; i<=$#; i++)); do
    local a=$@[i]
    if [[ $a == - ]]; then
      args[i]=`cat`
    else
      args[i]=$a
    fi
  done

  $args
}

avg_time() {
    #
    # usage: avg_time n command ...
    #
    n=$1; shift
    (($# > 0)) || return                   # bail if no command given
    for ((i = 0; i < n; i++)); do
        ( /usr/bin/time -p "$@" > /dev/null ) 2>&1 # ignore the output of the command
                                           # but collect time's output in stdout
    done | awk '
        /real/ { real = real + $2; nr++ }
        /user/ { user = user + $2; nu++ }
        /sys/  { sys  = sys  + $2; ns++}
        END    {
                if (nr>0) printf("real %f\n", real/nr);
                if (nu>0) printf("user %f\n", user/nu);
                if (ns>0) printf("sys %f\n",  sys/ns)
              }'
}

# alcurl() {
#   aze here $HOME/bin/alcurl $@
# }

alias y="yarn"
alias yw="yarn workspace"
alias ys="yarn start"
alias yi="yarn ios:sandbox"
alias yis="yarn ios:sandbox"
alias ya="yarn android:sandbox"
alias yas="yarn android:sandbox"
alias ysb="yarn storybook"

# alias ni="npm install"
# alias nr="npm run"
# alias nrb="npm run build"
# alias nrt="npm run test"
# alias nrr="npm run reset"
# alias pn="pnpm"
# alias pni="pnpm install"
# alias pnu="rm pnpm-lock.yaml; pnpm update"
# alias pnr="pnpm run"
# alias pnrb="pnpm run build"
# alias pnrt="pnpm run test"

if [[ -f $HOME/git/cdf-facade/shell-aliases.bash ]]; then
  source $HOME/git/cdf-facade/shell-aliases.bash
fi

alias nod="NODE_PATH=$HOME/.dotfiles/node_modules node --interactive --experimental-repl-await --eval=\"
const _ = require('lodash');
const async = require('async');
const fs = require('fs');
const fsp = fs.promises;
const delay = require('delay');
const inversify = require('inversify');
const faker = require('faker');
const moment = require('moment');
const momentTZ = require('moment-timezone');
const pem = require('pem');
const convert = require('convert-units');
const chrono = require('chrono-node');
const inflection = require('inflection');
const CryptoJS = require('crypto-js');
const cronParser = require('cron-parser');
const later = require('@breejs/later');
const immer = require('immer');
const rtk = require('@reduxjs/toolkit');
const redux = require('redux');
const reduxSaga = require('redux-saga');
const dateFns = require('date-fns');
const XLSX = require('xlsx');
const xml = require('fast-xml-parser');
const xml2js = require('xml2js');
const mobx = require('mobx');
const semver = require('semver');
const ES_data = require('$HOME/.dotfiles/es_data');\""
alias nodd="NODE_PATH=$HOME/.dotfiles/node_modules node"
alias ts-nod="(cd $HOME/.dotfiles && exec ts-node --interactive --project $HOME/.dotfiles/tsconfig.json --cwd $HOME/.dotfiles $HOME/.dotfiles/ts-nod.ts)"

export CDF_V1_TYPE="application/vnd.aws-cdf-v1.0+json"

# Hackintosh
alias esp_internal="$HOME/.dotfiles/hackintosh/mount_internal"
alias esp_usb="$HOME/.dotfiles/hackintosh/mount_usb"

# Docker
# eval $(docker-machine env default)
# export LOCALSTACK_HOST=$(docker-machine ip)

export LOCALSTACK_AUTH_TOKEN=$( cat $HOME/.localstack-auth-token )

# npm executables
export PATH="$PATH:$HOME/.dotfiles/node_modules/.bin"

# NOTE: Mono bugs
# Prevent IOException: kqueue() FileSystemWatcher has reached the maximum nunmber of files to watch.
export MONO_MANAGED_WATCHER=false
# https://github.com/dotnet/netcorecli-fsc/wiki/.NET-Core-SDK-1.0#using-net-framework-as-targets-framework-the-osxunix-build-fails
# https://github.com/dotnet/sdk/issues/335
if which mono > /dev/null; then
  export FrameworkPathOverride=$(dirname $(which mono))/../lib/mono/4.5/
fi

# Not sure I need any of these PATH mods...
# qt
export PATH="/usr/local/opt/qt/bin:$PATH"

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# python
export PATH=/usr/local/opt/python/libexec/bin:$PATH

# iTerm2 stuff
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# iterm2_print_user_vars() {
#   iterm2_set_user_var nodeVersion "$(node --version)"
#   iterm2_set_user_var rubyVersion "$(rbenv version-name)"
# }

DISABLE_AUTO_TITLE="true"

precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

update_iterm2_vars() {
  iterm2_set_user_var nodeVersion "$( set -o pipefail && asdf current nodejs | cut -w -f2 || node --version )"
  iterm2_set_user_var rubyVersion "$( set -o pipefail && asdf current ruby 2> /dev/null | cut -w -f2 || rbenv version-name )"
  iterm2_set_user_var pythonVersion "$( set -o pipefail && asdf current python 2> /dev/null | cut -w -f2 || python --version | sed 's/^Python //' )"
}

(update_iterm2_vars &)

function check_is_versioned() {
  local is_versioned=false
  for version_manager_file in $version_manager_files; do
    if [[ -r "$PWD/$version_manager_file" ]]; then
      return 0
    fi
  done
  return 1
}

# Keep asdf settings in sync with cwd
version_manager_files=(.tool-versions .nvmrc .ruby-version)
function chpwd {
  (update_iterm2_vars &)
  # if ! check_is_versioned; then
  #   return
  # fi
  # if [[ -r "$PWD/.tool-versions" ]]; then
  #   local installed=$( asdf plugin list )
  #   local wanted=$( cut -d' ' -f1 .tool-versions )
  #   local missing=$( echo $wanted $installed $installed | tr ' ' '\n' | sort | uniq -u )
  #   for missing in $missing; do
  #     asdf plugin add $missing
  #   done
  # fi
  # (asdf current 2>&1 | grep "Not installed") && asdf install
}

# asdf shell integration
source /usr/local/opt/asdf/libexec/asdf.sh

# Trying to avoid non-asdf managers...

# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# # [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# # place this after nvm initialization!
# autoload -U add-zsh-hook
# load-nvmrc() {
#   local nvmrc_path
#   nvmrc_path="$(nvm_find_nvmrc)"

#   if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version
#     nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     if [ "$nvmrc_node_version" = "N/A" ]; then
#       nvm install
#     elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
#       nvm use
#     fi
#   elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# # In zsh, the chpwd will run a command every time you change directories.
# function chpwd {
#   # Check if a .ruby-version file exists
#   if [[ -f "$PWD/.ruby-version" ]]; then
#     ruby_version=`cat .ruby-version`
#     if [[ ! -d "$HOME/.rbenv/versions/$ruby_version" ]]; then
#       while true; do
#         read REPLY\?"Ruby $ruby_version is not installed. Install it? [Yn] "
#         case $REPLY in
#           [Yy]* ) rbenv install $ruby_version; break;;
#           [Nn]* ) break;;
#           * ) echo "Please answer y or n.";;
#         esac
#       done
#     fi
#   fi
# }

export DIRENV_LOG_FORMAT=""
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
