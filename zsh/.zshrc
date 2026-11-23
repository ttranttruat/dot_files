# ===============================
# Environment
# ===============================
[[ -o interactive ]] || return

export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"
export PATH="$HOME/.local/bin:$PATH"

typeset -U path fpath
path=("$HOME/.local/bin" "$HOME/bin" $path)
fpath=(/usr/share/zsh/site-functions /usr/share/zsh/vendor-completions $fpath)

# ===============================
# History
# ===============================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=20000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# ===============================
# Shell options
# ===============================
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

# ===============================
# Zinit initialization
# ===============================
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -r $ZINIT_HOME/zinit.zsh ]] && (( $+commands[git] )); then
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

if [[ -r $ZINIT_HOME/zinit.zsh ]]; then
    source "$ZINIT_HOME/zinit.zsh"
else
    print -P "%F{yellow}Zinit is not available (needs git and network): plugins are skipped%f" >&2
fi

# ===============================
# Plugins
# ===============================
if (( $+commands[fzf] )); then
    for f in /usr/share/doc/fzf/examples/{key-bindings,completion}.zsh(N); do
        source $f
    done
fi

autoload -Uz compinit
compinit

[[ -z $LS_COLORS ]] && (( $+commands[dircolors] )) && eval "$(dircolors -b)"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

if (( $+functions[zinit] )); then
    if (( $+commands[fzf] )); then
        zinit light Aloxaf/fzf-tab

        zstyle ':completion:*' menu no
        zstyle ':completion:*:descriptions' format '[%d]'
        zstyle ':fzf-tab:*' switch-group '<' '>'

        if (( $+commands[eza] )); then
            zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=auto $realpath'
        fi
    fi

    zinit light zsh-users/zsh-autosuggestions
    zinit light zsh-users/zsh-syntax-highlighting
fi

(( $+commands[bat] )) && _bat="bat"
(( $+commands[batcat] )) && : ${_bat:=batcat}

if [[ -n $_bat ]]; then
    (( $+commands[bat] )) || alias bat="batcat"

    export BAT_THEME="ansi"
    export MANPAGER="sh -c 'col -bx | $_bat -l man -p'"
    export MANROFFOPT="-c"

    alias cat="$_bat --paging=never"

    if (( $+commands[fzf] )); then
        export FZF_CTRL_T_OPTS="--preview '$_bat --color=always --style=numbers --line-range=:200 {}'"
    fi
fi
unset _bat

# ===============================
# Alias
# ===============================
if (( $+commands[eza] )); then
    alias ls="eza"
    alias ll="eza -lah"
fi

if (( $+commands[git] )); then
    alias gst="git status"
    alias ga="git add"
    alias gcm="git commit -m"
    alias gp="git push"
fi

# ===============================
# Starship prompt
# ===============================
(( $+commands[starship] )) && eval "$(starship init zsh)"
