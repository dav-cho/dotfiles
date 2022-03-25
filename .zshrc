# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  z
  fzf
)
source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(pyenv init -)"

export FZF_DEFAULT_COMMAND="rg --files --smart-case --hidden --no-ignore-vcs --follow"
export FZF_CTRL_T_COMMAND="rg --files --smart-case --hidden --no-ignore-vcs --follow"
export FZF_ALT_C_COMMAND='rg --hidden --files --null | xargs -0 dirname | uniq'

export FZF_DEFAULT_OPTS="--multi --no-height --layout=reverse --info=inline --border"
export FZF_CTRL_T_OPTS="--preview 'bat --theme=\"Visual Studio Dark+\" --style=numbers --color=always --line-range :500 {}' --preview-window :hidden --bind '?:toggle-preview'"
# export FZF_CTRL_T_OPTS="--preview 'bat --theme=Dracula --style=numbers --color=always --line-range :500 {}' --preview-window :hidden --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# export FZF_TMUX_OPTS=''

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias gdot="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias ls="lsd"
alias la="lsd -a"
alias ll="lsd -l"
alias lla="lsd -la"
alias lt="lsd --tree"
alias ltd="lsd --tree --depth"

