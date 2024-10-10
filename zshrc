if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
export DISABLE_MAGIC_FUNCTIONS=true
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --height=~80%"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245"
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=green"
ZSH_HIGHLIGHT_STYLES[path]="fg=cyan"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=green"
plugins=(
  fzf-tab
  docker
  docker-compose
  fancy-ctrl-z
  fzf
  gh
  git
  gitfast
  kubectl
  zoxide
  zsh-autosuggestions
  zsh-syntax-highlighting
)
[[ -s $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
export VISUAL=nvim
export LESS="--mouse -R"
# export MANPAGER='nvim +Man!'

export BAT_STYLE="plain"
export BAT_THEME="Coldark-Dark"
export EZA_COLORS='xx=38;5;246:xa=38;5;246:'\
'ur=38;5;246:uw=38;5;250:ux=38;5;254:ue=38;5;254:'\
'gr=38;5;246:gw=38;5;250:gx=38;5;254:'\
'tr=38;5;246:tw=38;5;250:tx=38;5;254:'\
'sn=38;5;131:sb=38;5;131:'\
'uu=38;5;246:gu=38;5;246:da=38;5;246'

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -e "$HOME/.env" ]] && source "$HOME/.env"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
export PIPENV_VENV_IN_PROJECT=1

command -v uv >/dev/null && eval "$(uv generate-shell-completion zsh)"
command -v uvx >/dev/null && eval "$(uvx --generate-shell-completion zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use

export FZF_DEFAULT_COMMAND="fd --unrestricted --exclude .git --exclude node_modules --exclude __pycache__"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --unrestricted --exclude .git --exclude node_modules --exclude __pycache__"
export FZF_DEFAULT_OPTS="
  --cycle
  --multi
  --scrollbar='▐'
  --preview='if [[ -f {1} ]]; then bat --color=always --style=numbers --line-range=:500 {}; else eza --tree --color=always {}; fi'
  --bind='ctrl-f:page-down'
  --bind='ctrl-b:page-up'
  --bind='ctrl-d:preview-page-down'
  --bind='ctrl-u:preview-page-up'
  --bind='ctrl-_:toggle-preview'
  --bind='alt-p:change-preview-window(down|right)'
  --bind='alt-f:change-prompt(󰈙 > )+reload(fd -t f -u -E .git -E node_modules -E __pycache__)'
  --bind='alt-d:change-prompt(󰉋 > )+reload(fd -t d -u -E .git -E node_modules -E __pycache__)'
  --bind='alt-.:change-prompt(.> )+reload(fd -t d -u)'
  --bind='ctrl-v:become(nvim {+} < /dev/tty > /dev/tty)'
  --bind='ctrl-y:execute-silent(echo {+} | tr -d '\''\n'\'' | pbcopy)'
  --bind='ctrl-\:toggle'
  --bind='alt-j:toggle+down'
  --bind='alt-k:toggle+up'
  --bind='alt-space:jump'
  --bind='alt-/:jump-accept'
"
export FZF_CTRL_T_OPTS=""
export FZF_ALT_C_OPTS="--preview='eza --tree --color=always {}'"
export FZF_CTRL_R_OPTS="
  --preview='echo {}'
  --preview-window='up:3:hidden:wrap'
  --bind='ctrl-y:execute-silent(echo -n {2..} | pbcopy)'
"
[[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --color=always $realpath'

eval "$(atuin init zsh)"
# . "$HOME/.atuin/bin/env"

[[ -e "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

[[ ! -f ~/.p10k.zsh ]] || . ~/.p10k.zsh

_fzf_compgen_path() {
  fd -u --follow -E ".git" -E "node_modules" -E "__pycache__" . "$1"
}

_fzf_compgen_dir() {
  fd --type d -u --follow -E ".git" -E "node_modules" -E "__pycache__" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd) fzf --preview 'tree -C {}' "$@" ;;
     *) fzf --preview 'if [[ -f {1} ]]; then bat --color=always --style=numbers --line-range=:500 {}; else eza -T --color=always {}; fi' "$@" ;;
  esac
}

_nvim() {
  case "$BUFFER" in
    '')
      if [[ -f Session.vim ]]; then
        nvim -S
      else
        nvim
      fi
      ;;
    *)  [[ -f "$BUFFER" ]] && nvim "$BUFFER" ;;
  esac
}

_nvim-man() {
  BUFFER+=" | nvim +Man! +colorscheme\ tokyonight"
  zle accept-line
}

_delta() {
  BUFFER+=" | delta"
  zle accept-line
}

_rfv() {
  rfv
}

zle -N _nvim
zle -N _nvim-man
zle -N _delta
zle -N _rfv

bindkey -e '^V' _nvim
bindkey -e '^[M' _nvim-man
bindkey -e '^[D' _delta
bindkey -e '^G' _rfv

bindkey -e '^[r' fzf-history-widget

bindkey -e '^[ ' autosuggest-execute
bindkey -e '^[l' autosuggest-execute
bindkey -e '^[u' backward-kill-line
bindkey -e '^[e' edit-command-line
bindkey -e '^U' kill-whole-line
bindkey -e '^X^I' toggle-fzf-tab
bindkey -e '^[v' quoted-insert

alias cat="bat"
alias docker-compose="docker compose"
alias eza="eza --time-style=long-iso"
alias ghco="gh copilot"
alias mann="MANPAGER='nvim +Man! +colorscheme\ tokyonight' man"
alias rg="rg --smart-case"
# alias mann="MANPAGER='nvim +Man! +colorscheme\ onenord' man"
# alias nvimm="nvim +syntax\ off +filetype\ off +set\ noswapfile +set\ norelativenumber"
# alias nvimm="nvim +syntax\ off +filetype\ off +set\ noswapfile +set\ noundofile +set\ norelativenumber"

alias gcnn!='git commit --verbose --no-edit --amend --date=now'
alias gdni="git diff --no-index --"
alias gdno="git diff --name-only"
alias gdst="git diff --stat"
alias ghn="MANPAGER='nvim +Man! +colorscheme\ tokyonight' git help"
alias gl1="git log -1 --stat --pretty=fuller"
alias gl="git log --oneline"
alias gla="git log --oneline --all"
alias glc='git log --pretty="format:%C(auto)%h %C(dim blue)%an %C(green)%ad %C(reset blue)%cn %C(green)%cd%C(auto)%d %s" --date="format:%Y-%m-%d %H:%M:%S"'
alias gld='git log --pretty="format:%C(auto)%h %C(dim green)%ad%C(auto)%d %s %C(green)(%ar)" --date="format:%Y-%m-%d %H:%M:%S"'
alias gle='git log --pretty="format:%C(auto)%h %C(dim blue)%an %C(magenta)%ae%C(auto)%d %s"'
alias glh='git log --simplify-by-decoration --pretty="format:%C(auto)%h %C(dim blue)%an %C(green)%ad%C(auto)%d %s %C(green)(%ar)" --date="format:%Y-%m-%d %H:%M:%S"'
alias gll='git log --pretty="format:%C(auto)%h %C(dim blue)%an %C(green)%ad%C(auto)%d %s %C(green)(%ar)" --date="format:%Y-%m-%d %H:%M:%S"'
alias glll='git log --pretty="format:%C(auto)%h %C(dim blue)%an %C(magenta)%ae %C(green)%ad%C(auto)%d %s %C(green)(%ar)" --date="format:%Y-%m-%d %H:%M:%S"'
alias gllr='git log --pretty="format:%C(auto)%h %C(dim blue)%an %C(green)%ad %C(reset magenta)%m%C(auto)%d% s %C(green)(%ar)" --date="format:%Y-%m-%d %H:%M:%S"'
alias gln='git log --pretty="format:%C(auto)%h %C(dim blue)%an%C(auto)%d %s"'
alias glnd="git log --oneline --no-decorate"
alias glo="git log"
alias glop="git log --stat --patch --reverse ORIG_HEAD.."
alias glorig="git log --oneline ORIG_HEAD.."
alias glp="git log --oneline --first-parent"
alias gls="git log --oneline --stat"
alias glt="git log --oneline -10"
alias glup='git log --pretty="format:%C(auto)%h %C(dim blue)%an %C(green)%ad %C(reset magenta)%m%C(auto)%d% s %C(green)(%ar)" --date="format:%Y-%m-%d %H:%M:%S" @{u}...'
alias gmnf="git merge --no-ff"
alias gs="git status --short"
alias gu="git pull"

alias l="eza -la --icons=auto"
alias la="eza -laa --icons=auto"
alias lg="eza -laaG --icons=auto"
alias ll="eza -l --icons=auto"
alias lt="eza --tree -I __pycache__"

if [[ "$USER" == "dcho" ]]; then
  source "$HOME/dotfiles/cm/zshrc-cm"
fi
