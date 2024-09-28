source "$HOME/.zsh_aliases"

if [[ -f ~/.dir_colors ]]; then
    eval $(dircolors -b ~/.dir_colors | sed 's/=/=/g')
elif [[ -f /etc/DIR_COLORS ]]; then
    eval $(dircolors -b /etc/DIR_COLORS | sed 's/=/=/g')
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

#determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi
#refer rg over ag
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit light-mode for \
    zsh-users/zsh-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    Aloxaf/fzf-tab

# Add in snippets
autoload -Uz zinit snippet OMZP::git
autoload -Uz zinit snippet OMZP::sudo
autoload -Uz zinit snippet OMZP::command-not-found

zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -f "$zcompdump" && "$zcompdump" -ot "${ZDOTDIR:-$HOME}/.zshrc" ]]; then
  compinit -d "$zcompdump"
else
  compinit
fi

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/ghost.toml)"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias wifi='nmcli device wifi'

paths=(
  "$HOME/zig-linux-x86_64-0.12.0"
  "$HOME/rohan/.cargo/bin"
  "$HOME/rohan/.cargo/bin/kanata"
  "/bin" "/usr/bin"
  "/usr/local/go/bin"
  "$HOME/go/bin"
  "/usr/local/bin"
  "~/.console-ninja/.bin"
  "/snap/bin"
)
PATH=$(printf "%s:" "${paths[@]}")$PATH


lazynvm() {
  # Unset existing functions
  unset -f nvm node npm npx

  # Load nvm if necessary
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

  # Load nvm bash completion if necessary
  [ -f "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

# Define lazy-loaded functions for nvm, node, npm, and npx
nvm() { lazynvm nvm $@ }
node() { lazynvm node $@ }
npm() { lazynvm npm $@ }
npx() { lazynvm npx $@ }


. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init zsh)"

PATH=~/.console-ninja/.bin:$PATH