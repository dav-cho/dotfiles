export EDITOR=nvim
export VISUAL=nvim
export LESS="--mouse -R"
export MANPAGER='nvim +Man!'

export BAT_STYLE="plain"
export BAT_THEME="Visual Studio Dark+"
export DISABLE_MAGIC_FUNCTIONS=true
export NVM_DIR="$HOME/.nvm"
export PYENV_ROOT="$HOME/.pyenv"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

export FZF_DEFAULT_OPTS="
  --multi
  --reverse
  --cycle
  --info=inline
  --border=none
  --separator=''
  --scrollbar='▐'
  --preview='bat --color=always --style=numbers --line-range=:500 {}'
  --preview-window=hidden,wrap,down
  --bind='backward-eof:abort'
  --bind=ctrl-_:toggle-preview
  --bind='alt-j:select+down'
  --bind='alt-k:deselect+up'
  --bind='ctrl-n:select+down'
  --bind='ctrl-p:select+up'
  --bind='alt-n:deselect+down'
  --bind='alt-p:deselect+up'
  --bind='shift-down:half-page-down'
  --bind='shift-up:half-page-up'
  --bind='ctrl-d:preview-half-page-down'
  --bind='ctrl-u:preview-half-page-up'
  --bind='ctrl-v:become(nvim {+} < /dev/tty > /dev/tty)'
  --bind='ctrl-y:execute-silent(echo {+} | tr -d '\''\n'\'' | pbcopy)+abort'
  --bind='alt-enter:change-prompt(Files > )+reload(fd --type file --unrestricted)'
  --bind='alt-bspace:change-prompt(Directories > )+reload(fd --type directory --no-ignore)'
"
export FZF_CTRL_T_OPTS="--preview-window=right"
export FZF_ALT_C_OPTS="--preview='tree -C {} | head -200' --preview-window=nohidden,right"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window=hidden,down,5,wrap"
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --height=~50%"

export FZF_DEFAULT_COMMAND="fd --hidden --no-ignore"
export FZF_CTRL_T_COMMAND="fd"
export FZF_ALT_C_COMMAND="fd --type directory"

typeset -A ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_STYLES=(
  [autodirectory]="fg=green"
  [path]="fg=cyan"
  [precommand]="fg=green"
)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245"

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -e "$HOME/.env" ]] && source "$HOME/.env"

if [[ $USER == "dcho" ]]; then
  export PIPENV_DEFAULT_PYTHON_VERSION="3.11.5"
fi
