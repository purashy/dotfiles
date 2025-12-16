# Enable colors and change prompt:
autoload -U compinit && compinit
autoload -Uz colors && colors
export CLICOLOR=1

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Fix delete key and ctrl + arrow keys
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Fixing some issue with locale
export LC_ALL="en_US.UTF-8"

# I use Arch, BTW
fastfetch --config $HOME/.config/fastfetch/config.jsonc

# Source .zsh*
source ~/.zsh_aliases
source ~/.zshenv

# Prompt/PS1
NEWLINE=$'\n'
PROMPT="${NEWLINE}%F{105}%n%f%F{168}@%f%F{75}%m%f %F{49}%~%f%F{168} - %f[%*] ${NEWLINE}%B%F{220}$%f%b "

# Some CUDA stuff (comment out or remove these if you are not using Nvidia GPU)
export PATH=/opt/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/opt/cuda/lib64

# Bitwarden SSH Agent
export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

