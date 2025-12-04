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

export BAT_STYLE="plain"
export BAT_THEME="Visual Studio Dark+"
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

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL" ]] && export PATH="$BUN_INSTALL/bin:$PATH"

export FZF_DEFAULT_COMMAND="fd --exclude .git --exclude node_modules --exclude __pycache__"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_DEFAULT_OPTS="
  --cycle
  --multi
  --layout=reverse
  --height=100%
  --history=$HOME/.fzf.zsh.history
  --scrollbar='▐'
  --preview='if [[ -f {1} ]]; then bat --color=always --style=numbers --line-range=:500 {}; else eza --tree --color=always {}; fi'
  --bind='ctrl-\:toggle'
  --bind='ctrl-r:change-prompt(> )+reload($FZF_DEFAULT_COMMAND)'
  --bind='ctrl-n:toggle+down'
  --bind='ctrl-p:toggle+up'
  --bind='ctrl-f:page-down'
  --bind='ctrl-b:page-up'
  --bind='ctrl-v:become(nvim {+} < /dev/tty > /dev/tty)'
  --bind='ctrl-y:execute-silent(echo {+} | tr -d '\''\n'\'' | pbcopy)'
  --bind='ctrl-_:toggle-preview'
  --bind='ctrl-]:change-preview-window(down|right)'
  --bind='alt-f:preview-page-down'
  --bind='alt-b:preview-page-up'
  --bind='alt-d:preview-half-page-down'
  --bind='alt-u:preview-half-page-up'
  --bind='alt-h:first'
  --bind='alt-l:last'
  --bind='alt-c:clear-multi'
  --bind='alt-n:next-history'
  --bind='alt-p:prev-history'
  --bind='alt-\:toggle-all'
  --bind='alt-enter:select-all+accept'
  --bind='alt-space:jump'
  --bind='alt-/:jump-accept'
  --bind='alt-F:change-prompt(󰈙 > )+reload($FZF_DEFAULT_COMMAND -t f)'
  --bind='alt-D:change-prompt(󰉋 > )+reload($FZF_DEFAULT_COMMAND -t d)'
  --bind='alt-U:change-prompt(> )+reload($FZF_DEFAULT_COMMAND --unrestricted)'
  --bind='alt-.:change-prompt(.> )+reload(fd -t d -u)'
"
export FZF_CTRL_T_OPTS=""
export FZF_ALT_C_OPTS="--preview='eza --tree --color=always {}'"
export FZF_CTRL_R_OPTS="
  --preview='echo {}'
  --preview-window='up:3:hidden:wrap'
  --bind='ctrl-y:execute-silent(echo -n {2..} | pbcopy)'
"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:complete:*' fzf-preview 'if [[ -f $realpath ]]; then bat --color=always --style=numbers --line-range=:500 $realpath; else eza --tree --color=always $realpath; fi'
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-y:execute-silent({_FTB_INIT_}echo "$realpath" | tr -d "\n" | pbcopy)'

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh --disable-up-arrow)"

[[ -e "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

eval "$(gh copilot alias -- zsh)"

export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

[[ ! -f ~/.p10k.zsh ]] || . ~/.p10k.zsh

_claude() {
  if [[ $(nvm current) == "system" ]]; then
    nvm use default
  fi
  command claude "$@"
}

_fzf_compgen_path() {
  fd -u --follow --strip-cwd-prefix -E ".git" -E "node_modules" -E "__pycache__" . "$1"
}

_fzf_compgen_dir() {
  fd --type d -u --follow --strip-cwd-prefix -E ".git" -E "node_modules" -E "__pycache__" . "$1"
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

_rfv() {
  rfv
}

zle -N _nvim
zle -N _nvim-man
zle -N _pipe-delta
zle -N _pipe-fzf
zle -N _rfv

bindkey -e '^V' _nvim
bindkey -e '^[M' _nvim-man
bindkey -e '^G' _rfv

bindkey -e '^[r' atuin-up-search
bindkey -e '^[R' fzf-history-widget
bindkey -e '^X^I' toggle-fzf-tab

bindkey -e '^[l' autosuggest-execute
bindkey -e '^[u' backward-kill-line
bindkey -e '^[e' edit-command-line
bindkey -e '^[v' quoted-insert
bindkey -e '^[/' redo
bindkey -e '^[U' up-case-word
bindkey -e '^[B' vi-backward-blank-word
bindkey -e '^[F' vi-forward-blank-word

alias cat="bat"
alias chrome="open -a 'Google Chrome'"
alias cld="_claude"
alias docker-compose="docker compose"
alias eza="eza --time-style=long-iso"
alias firefox="open -a 'Firefox'"
alias ghco="gh copilot"
alias mann="MANPAGER='nvim +Man! +colorscheme\ tokyonight' man"
alias nvmd="nvm use default"
alias nvml="nvm use --lts"
alias nvms="nvm use system"
alias rg="rg --smart-case"

alias gcnn!='git commit --verbose --no-edit --amend --date=now'
alias gdmb='git diff $(git merge-base $(git_main_branch) HEAD)..'
alias gdni="git diff --no-index --"
alias gdno="git diff --name-only"
alias gdst="git diff --stat"
alias ghhh="MANPAGER='nvim +Man! +colorscheme\ tokyonight' git help"
alias gl1='git log -1 --stat'
alias gl='git log --pretty=oneline-reldate-name-email'
alias gla="git log --oneline --all"
alias glc='git log --pretty=oneline-name-email'
alias gld='git log --pretty=oneline-fulldate --date=iso'
alias glf='git log --pretty=fuller'
alias glh='git log --simplify-by-decoration --pretty=oneline-fulldate --date=iso'
alias gll='git logdate --pretty=oneline-fulldate-name-email'
alias gllr='git log --pretty=oneline-mark-reldate'
alias glmb='git log --pretty=oneline-reldate-name-email $(git merge-base $(git_main_branch) HEAD)..'
alias glo="git log"
alias glomb='git log $(git merge-base $(git_main_branch) HEAD)..'
alias glop="git log --stat --patch --reverse ORIG_HEAD.."
alias glorig='git log --pretty=oneline-reldate-name-email --date=iso ORIG_HEAD..'
alias glp="git log --first-parent --pretty=oneline-reldate-name-email"
alias glst="git log --oneline --stat"
alias glt='git log --pretty=oneline-reldate-name-email -10'
alias glu='git log --pretty=oneline-reldate-name-email ..@{u}'
alias glup='git log --pretty=oneline-mark-reldate ...@{u}'
alias glz="git log --oneline | fzf --preview 'git show --color {1}'"
alias gmnf="git merge --no-ff"
alias gs="git status --short"
alias gstz="git stash list | fzf --preview 'git stash show -p --color \$(echo {1} | cut -d: -f1)'"
alias gsww='git switch $(git branch --format="%(refname:short)" | fzf --no-preview) 2>/dev/null'
alias gu="git pull"

alias l="eza -la --icons=auto"
alias la="eza -laa --icons=auto"
alias lg="eza -laaG --icons=auto"
alias ll="eza -l --icons=auto"
alias lt="eza --tree -I 'node_modules|__pycache__'"

[[ -e "$HOME/._work" && -s "$HOME/dotfiles/work/zshrc" ]] && source "$HOME/dotfiles/work/zshrc"
