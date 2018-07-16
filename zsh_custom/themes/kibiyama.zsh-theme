unity_custom_status() {
  if which uvm &> /dev/null; then
    if uvm local &> /dev/null; then
      echo "%{$reset_color%}%{$fg[yellow]%}[Unity:$(uvm local)]%{$reset_color%}"
    fi
  fi
}

rbenv_custom_status() {
  if which rbenv &> /dev/null; then
    if rbenv local &> /dev/null; then
      echo "%{$reset_color%}%{$fg[red]%}[ruby:$(rbenv local)]%{$reset_color%}"
    fi
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}|"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}>"
ZSH_THEME_GIT_PROMPT_CLEAN=">"

git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

local user_host='%{$reset_color%}%{$fg[green]%}%n%{$fg[green]%}@%m:'
local current_dir='%{$fg[cyan]%}%~%{$reset_color%}'
PROMPT="${user_host}${current_dir}\$(git_custom_status)%{$reset_color%} "
RPROMPT="\$(unity_custom_status)\$(rbenv_custom_status)"
