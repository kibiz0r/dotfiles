function git_status() {
  local DIRTY=''
  local STAGED=''
  local BEHIND=''

  local -a FLAGS
  FLAGS=('--porcelain' '--branch')

  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi

    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi

    GIT_STATUS_OUTPUT=$( command git status ${FLAGS} 2> /dev/null )

    GIT_BRANCH_STATUS=$( echo $GIT_STATUS_OUTPUT | head -n 1 )
    GIT_FILES_STATUS=$( echo $GIT_STATUS_OUTPUT | tail -n +2 )

    DIRTY=$( echo $GIT_FILES_STATUS | egrep "^.[^ ]" )
    STAGED=$( echo $GIT_FILES_STATUS | egrep "^[^ ]" )

    AHEAD=$( echo $GIT_BRANCH_STATUS | egrep "\[.*ahead.*\]\$" )
    BEHIND=$( echo $GIT_BRANCH_STATUS | egrep "\[.*behind.*\]\$" )
    NO_BRANCH=$( echo $GIT_BRANCH_STATUS | egrep "^## HEAD \(no branch\)\$" )
    GONE=$( echo $GIT_BRANCH_STATUS | egrep "\[gone\]\$" )
  fi

  local TO_ECHO=''

  if [[ -n $DIRTY ]]; then
    TO_ECHO+="$ZSH_THEME_GIT_PROMPT_DIRTY"
  elif [[ -n $STAGED ]]; then
    TO_ECHO+="$ZSH_THEME_GIT_PROMPT_STAGED"
  fi

  if [[ -n $NO_BRANCH ]]; then
    TO_ECHO+="$ZSH_THEME_GIT_PROMPT_DETACHED"
  elif [[ -n $AHEAD ]] && [[ -n $BEHIND ]]; then
    TO_ECHO+="$ZSH_THEME_GIT_PROMPT_DIVERGENT"
  elif [[ -n $AHEAD ]]; then
    TO_ECHO+="$ZSH_THEME_GIT_PROMPT_AHEAD"
  elif [[ -n $BEHIND ]]; then
    TO_ECHO+="$ZSH_THEME_GIT_PROMPT_BEHIND"
  elif [[ -n $GONE ]]; then
    TO_ECHO+="$ZSH_THEME_GIT_PROMPT_GONE"
  else
    TO_ECHO+="$ZSH_THEME_GIT_PROMPT_CURRENT"
  fi

  echo $TO_ECHO
}

# unity_custom_status() {
#   if which uvm &> /dev/null; then
#     if uvm local &> /dev/null; then
#       echo "%{$reset_color%}%{$fg[yellow]%}[Unity:$(uvm local)]%{$reset_color%}"
#     fi
#   fi
# }

# rbenv_custom_status() {
#   if which rbenv &> /dev/null; then
#     if rbenv local &> /dev/null; then
#       echo "%{$reset_color%}%{$fg[red]%}[ruby:$(rbenv local)]%{$reset_color%}"
#     fi
#   fi
# }

# nvm_custom_status() {
#   if which nvm &> /dev/null; then
#     local node=$(nvm current)
#     if [[ $node != "system" ]]; then
#       echo "%{$reset_color%}%{$fg[red]%}[node:$node]%{$reset_color%}"
#     fi
#   fi
# }

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}|"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}"

ZSH_THEME_GIT_PROMPT_DETACHED="?"
ZSH_THEME_GIT_PROMPT_BEHIND="]"
ZSH_THEME_GIT_PROMPT_AHEAD=")"
ZSH_THEME_GIT_PROMPT_DIVERGENT="}"
ZSH_THEME_GIT_PROMPT_GONE="|"
ZSH_THEME_GIT_PROMPT_CURRENT=">"

git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$(git_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CURRENT"
  fi
}

local user_host='%{$reset_color%}%{$fg[green]%}%n%{$fg[green]%}@%m:'
local current_dir='%{$fg[cyan]%}%~%{$reset_color%}'
PROMPT="${user_host}${current_dir}\$(git_custom_status)%{$reset_color%} "
# RPROMPT="\$(nvm_custom_status)"
# RPROMPT="\$(unity_custom_status)\$(rbenv_custom_status)"
