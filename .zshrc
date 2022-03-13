# Main -----------------------------------------------------

# Set alias for dot files --bare repo
alias gdot='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

# Oh-My-Zsh ------------------------------------------------

export ZSH="/Users/dav/.oh-my-zsh"
plugins=(
  git
  z
  fzf
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# p10k -----------------------------------------------------

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf ------------------------------------------------------

export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border'

# nvm ------------------------------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# pyenv ----------------------------------------------------

eval "$(pyenv init -)"

# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

