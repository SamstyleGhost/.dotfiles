zmodload zsh/zprof

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

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

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

PATH=$HOME/zig-linux-x86_64-0.12.0:$PATH
PATH=$PATH:$HOME/rohan/.cargo/bin
PATH=$PATH:$HOME/rohan/.cargo/bin/kanata
PATH=$PATH:/bin:/usr/bin
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:/usr/local/bin

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

zprof
