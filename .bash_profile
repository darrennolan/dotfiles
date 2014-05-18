# My Mac Should have the following enabled for purdy colors

if hash uname 2>&-; then
  os_type=`uname -s`
else
  os_type="unknown"
fi

if [[ $os_type == "Darwin" ]]; then
  export CLICOLOR=1
  export LSCOLORS=GxFxCxDxBxegedabagaced
  export TERM="xterm-color"
fi

# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
source $HOME/bin/git-completion.bash

# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source $HOME/bin/git-prompt.sh

function __git_dirty {
  git diff --quiet HEAD &>/dev/null
  [ $? == 1 ] && echo "!"
}

function __git_branch {
  __git_ps1 "[%s]"
}

bash_prompt() {
  local NONE="\[\033[0m\]"    # unsets color to term's fg color
  # regular colors
  local K="\[\033[1;30m\]"    # black
  local R="\[\033[1;31m\]"    # red
  local G="\[\033[1;32m\]"    # green
  local Y="\[\033[1;33m\]"    # yellow
  local B="\[\033[1;34m\]"    # blue
  local M="\[\033[1;35m\]"    # magenta
  local C="\[\033[1;36m\]"    # cyan
  local W="\[\033[1;37m\]"    # white
  local UC=$W                 # user's color
  [ $UID -eq "0" ] && UC=$R   # root's color
  PS1="$C\u$W@$B\h$C[$W\w$C]$G\$(__git_branch)$R\$(__git_dirty)$W+$NONE "
}
bash_prompt
unset bash_prompt
