# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  z
  fzf
  zsh-autosuggestions
  git
)
source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export FZF_DEFAULT_COMMAND="rg --files --smart-case --hidden --no-ignore-vcs --follow"
export FZF_CTRL_T_COMMAND="rg --files --smart-case --hidden --no-ignore-vcs --follow"
export FZF_ALT_C_COMMAND='rg --hidden --files --null | xargs -0 dirname | uniq'

export FZF_DEFAULT_OPTS="--multi --no-height --layout=reverse --info=inline"
export FZF_CTRL_T_OPTS="--preview 'bat --theme=\"Visual Studio Dark+\" --style=numbers --color=always --line-range :500 {}' --preview-window :hidden --bind '?:toggle-preview'"
# export FZF_CTRL_T_OPTS="--preview 'bat --theme=Dracula --style=numbers --color=always --line-range :500 {}' --preview-window :hidden --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_TMUX_OPTS="-p 80%,80%"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(pyenv init -)"

alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias ls="lsd"
alias la="ls -a"
alias lt="lsd --tree"
alias ltd="lsd --tree --depth"

alias gwt="git worktree"
alias gwtl="git worktree list"
alias gwta="git worktree add"
alias gwtr="git worktree remove"
alias gnoignore="git update-index --no-assume-unchanged"

if [ -d "$HOME/.config/bin" ]; then
  export PATH="$HOME/.config/bin:$PATH"
fi

