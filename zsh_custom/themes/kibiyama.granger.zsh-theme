#RVM settings
if [[ -s ~/.rvm/scripts/rvm ]]; then
  RPS1="%{$reset_color%}%{$fg[red]%}\$(~/.rvm/bin/rvm-prompt)%{$reset_color%} $EPS1"
elif [[ -s /usr/local/rvm/scripts/rvm ]]; then
  RPS1="%{$reset_color%}%{$fg[red]%}\$(/usr/local/rvm/bin/rvm-prompt)%{$reset_color%} $EPS1"
else
  if which rbenv &> /dev/null; then
    RPS1="%{$fg[yellow]%}rbenv:%{$reset_color%}%{$fg[red]%}\$(rbenv version | sed -e 's/ (set.*$//')%{$reset_color%} $EPS1"
  fi
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}|"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}>"
ZSH_THEME_GIT_PROMPT_CLEAN=">"

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

local user_host='%{$reset_color%}%{$fg[green]%}%n%{$fg[cyan]%}@%m:'
local current_dir='%{$fg[cyan]%}%~%{$reset_color%}'
PROMPT="${user_host}${current_dir}\$(git_custom_status)%{$reset_color%} "
