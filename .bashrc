#--------------------------dav------------------------------

alias ls='lsd'
alias lc='lsd --classic'
alias la='lsd -a'
alias lt='lsd --tree'

#alias lf='ls -a'
#alias lw='lsd'
#alias lr='lsd -a'
#alias le='lsd --tree -d'
#alias lt='lsd --tree'
#alias lg='lsd --tree --depth'
#alias lo='lsd -l'
#alias lq='lsd -la'
#alias ov='open -a "Visual Studio Code"'

#--------------------------dav------------------------------

# Git
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}
export PS1="\[$(tput bold)\]\w\[$(tput sgr0)\] \$(parse_git_branch)\n$ "
export EDITOR='code --wait'
export VISUAL='code --wait'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

