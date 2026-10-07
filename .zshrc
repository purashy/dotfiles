# ╭──────────────────────────────────────────────────────────╮
# │ ZSH                                                      │
# ╰──────────────────────────────────────────────────────────╯

# ------------------------------------------------------------
# Completion
# ------------------------------------------------------------

autoload -Uz compinit colors
colors

# Only initialize completion once.
compinit

zmodload zsh/complist

# Completion menu
zstyle ':completion:*' menu select

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Colored completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Include hidden files in completion
_comp_options+=(globdots)

# Better completion behavior
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# ------------------------------------------------------------
# History
# ------------------------------------------------------------

HISTFILE="$HOME/.cache/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

# History options
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY

# ------------------------------------------------------------
# Key bindings
# ------------------------------------------------------------

bindkey -e

# Delete key
bindkey '^[[3~' delete-char

# Ctrl + Left / Right
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# ------------------------------------------------------------
# Locale
# ------------------------------------------------------------

#export LANG='en_US.UTF-8'
#export LC_CTYPE='en_US.UTF-8'

# ------------------------------------------------------------
# General environment
# ------------------------------------------------------------

export CLICOLOR=1

# ------------------------------------------------------------
# CUDA
# ------------------------------------------------------------

if [[ -d /opt/cuda ]]; then
    export PATH="/opt/cuda/bin:$PATH"
    export LD_LIBRARY_PATH="/opt/cuda/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
fi

# ------------------------------------------------------------
# Bitwarden SSH Agent
# ------------------------------------------------------------

export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"

# ------------------------------------------------------------
# Aliases / environment
# ------------------------------------------------------------

[[ -f "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"

# .zshenv is automatically sourced by zsh.
# Do NOT source it here.

# ------------------------------------------------------------
# Fastfetch
# ------------------------------------------------------------

if command -v fastfetch >/dev/null 2>&1; then
    fastfetch --config "$HOME/.config/fastfetch/config.jsonc"
fi

# ------------------------------------------------------------
# Prompt
# ------------------------------------------------------------

setopt PROMPT_SUBST

function prompt_char() {
    if (( $? == 0 )); then
        print -n '%F{220}❯%f '
    else
        print -n '%F{196}✗%f '
    fi
}

PROMPT=$'\n'
PROMPT+='%F{105}%n%f'
PROMPT+='%F{168}@%f'
PROMPT+='%F{75}%m%f '
PROMPT+='%F{49}%~%f'
PROMPT+='%F{168} - %f'
PROMPT+='[%*]'
PROMPT+=$'\n'
PROMPT+='%B$(prompt_char)%b'

# ------------------------------------------------------------
# Plugins
# ------------------------------------------------------------

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Syntax highlighting MUST be loaded last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

