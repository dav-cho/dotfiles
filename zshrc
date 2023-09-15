if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  fzf-tab
  docker
  docker-compose
  fancy-ctrl-z
  fzf
  gh
  git
  gitfast
  ripgrep
  zoxide
  zsh-autosuggestions
  zsh-syntax-highlighting
)
[[ -s $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

[[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh
zstyle ':fzf-tab:*' fzf-bindings 'alt-j:toggle+down,alt-k:toggle+up'

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"

[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

compdef _tmux _tmux-run

_fzf-tmux() {
  local session=$(tmux ls -F '#S' |
    fzf --no-multi --bind 'alt-enter:execute(echo {q})+abort'
    tail -n 1)

  [[ -z $session ]] && return

  if [[ -n "$TMUX" ]]; then
    tmux new -d -s $session 2>/dev/null
    tmux switch-client -t $session
  else
    zle -U "tmux new -s $session 2>/dev/null || tmux a -t $session"
  fi
}

_history-edit() {
  nvim + $HISTFILE
}

_nvim() {
  nvim
}

_nvim-man() {
  BUFFER+=" | nvim +Man!"
  zle accept-line
}

_nvim-session() {
  if [[ -z $BUFFER ]]; then
    if [[ -f Session.vim ]]; then
      nvim -S
    else
      nvim
    fi
  else
    [[ ! $BUFFER =~ ^nvim ]] && echo $BUFFER | xargs nvim
  fi
}

_rfv() {
  rfv
}

_tmux_history() {
  nvim "$HOME/tmux.history"
}

zle -N _fzf-tmux
zle -N _history-edit
zle -N _nvim
zle -N _nvim-man
zle -N _nvim-session
zle -N _rfv
zle -N _tmux_history

bindkey -e '^X^M' _fzf-tmux
bindkey -e '^X^H' _history-edit
bindkey -e '^[V' _nvim
bindkey -e '^[M' _nvim-man
bindkey -e '^V' _nvim-session
bindkey -e '^G' _rfv
bindkey -e '^X^T' _tmux_history

bindkey -e '^[ ' autosuggest-execute
bindkey -e '^[l' autosuggest-execute
bindkey -e '^[u' backward-kill-line
bindkey -e '^[e' edit-command-line
bindkey -e '^U' kill-whole-line
bindkey -e '^X^I' toggle-fzf-tab
bindkey -e '^[v' quoted-insert

alias -s {lua,py}=nvim

alias gdni="git diff --no-index --"
alias gdno="git diff --name-only"
alias gdnvim="git difftool --no-prompt"
alias gl="git log --pretty='format:%C(auto)%h% D %s'"
alias glc="git log --pretty='format:%C(auto)%h% D %s %C(bold blue)%an%C(reset) %C(green)%ar%C(auto)'"
alias gld="git log --pretty='format:%C(auto)%h% D %s %C(bold blue)%an%C(reset) %C(green)%ad%C(auto)' --date=format:'%Y-%m-%d %H:%M:%S'"
alias glf="git log --stat --pretty=fuller"
alias glh="git log --pretty=oneline --no-decorate"
alias gll="git log --oneline --no-decorate"
alias glm="git log --first-parent --pretty='format:%C(auto)%h% D %s'"
alias glp="git log --stat --patch"
alias gls="git log --stat --pretty='format:%C(auto)%H% D%n %s%n'"
alias gmf="git merge --ff-only"
alias gmnf="git merge --no-ff"
alias gnoignore="git update-index --no-assume-unchanged"
alias gs="git status --short"
alias gstlp="git stash list --patch"
alias gsts="git stash show --patch"
alias gu="git pull"
alias guf="git pull --ff-only"
alias gwt="git worktree"
alias gwta="git worktree add"
alias gwtl="git worktree list"
alias gwtr="git worktree remove"
alias l="lsd -lah"
alias ll="lsd -lh"
alias lt="lsd --tree"
alias ltd="lsd --tree --depth"
alias rg="rg --smart-case"
alias sgpt="sgpt --no-animation"
