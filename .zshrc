# ─── Meta ───────────────────────────────────────────────────────
# Created by Phunt_Vieg_
# Ensure running interactively
[[ $- != *i* ]] && return

# ─── History ─────────────────────────────────────────────────────
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory

# ─── Keybinds ────────────────────────────────────────────────────
bindkey -e

# ─── FZF ─────────────────────────────────────────────────────────
eval "$(fzf --zsh)"
# FZF theme catppuccin
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"
export FZF_TAB_COLORS='fg:#CDD6F4,bg:#1E1E2E,hl:#F38BA8,min-height=5'

# ─── Zinit ───────────────────────────────────────────────────────
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${ZDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# ─── Completion ──────────────────────────────────────────────────
autoload -Uz compinit && compinit
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{A-Za-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --height=17
zstyle ':fzf-tab:complete:*' fzf-preview '
if [ -d "$realpath" ]; then
    eza --icons --tree --level=2 --color=always "$realpath"
elif [ -f "$realpath" ]; then
    bat -n --color=always --line-range :500 "$realpath"
fi
'

# ─── Aliases ─────────────────────────────────────────────────────
alias ls='eza --icons --color=always'
alias ll='eza --icons --color=always -l'
alias la='eza --icons --color=always -a'
alias lla='eza --icons --color=always -la'
alias lt='eza --icons --color=always -a --tree --level=1'
alias grep='grep --color=always'
alias vim='nvim'
alias lzg='lazygit'
alias lzd='lazydocker'
alias cbonsai='cbonsai -l -i -w 1'
alias c='clear'
alias fast='fastfetch'
alias concatena='~/scripts/concatena.sh'
alias exiftool="/usr/bin/vendor_perl/exiftool"
alias celular="scrcpy -d"
alias celularw="sudo systemctl start zerotier-one && sleep 2 && adb connect 10.204.202.47:5555 && scrcpy -s 10.204.202.47:5555 --max-size 800 --video-bit-rate 2M --max-fps 30 --audio-bit-rate 128k"
alias celularq="sudo systemctl start zerotier-one && sleep 2 && adb connect 10.204.202.47:5555 && scrcpy -s 10.204.202.47:5555 --max-size 1024 --video-bit-rate 4M --max-fps 60 --audio-bit-rate 192k"
alias celularf="sudo systemctl start zerotier-one && sleep 2 && adb connect 10.204.202.47:5555 && scrcpy -s 10.204.202.47:5555 --max-size 640 --video-bit-rate 1.5M --max-fps 30 --audio-bit-rate 96k"
alias tui="nmtui"

source ~/scripts/mac-rotate/mac.zshrc


# ─── Python Venv Functions ─────────────────────────────────────────
_activate_venv() { 
    if [[ -f "$1/bin/activate" ]]; then
        source "$1/bin/activate"
    else
        echo "Error: Virtual environment not found at '$1'."
    fi
}

mkvenv() {
    local name="${1:-.venv}"
    if [[ ! -d "$name" ]]; then
        python3 -m venv "$name" || return 1
    fi

    _activate_venv "$name"
}

venv() { _activate_venv "${1:-.venv}" }
pwnvenv() { _activate_venv "$HOME/pwndbg/.venv" }

# ─── Tools Init ──────────────────────────────────────────────────
# Setup bat (better than cat)
export BAT_THEME="base16"
alias bat='bat --paging=never'

# Setup zoxide (better than cd)
eval "$(zoxide init zsh)"

# Allowing comments in interactive zsh commands
setopt interactivecomments


# Pokemon startup
pokemon-colorscripts -s -r

# Initialize Oh-My-Posh
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/viet.omp.json)"

# Auto-start tmux
#if command -v tmux &> /dev/null; then
#  if [ -z "$TMUX" ]; then
#    tmux attach -t main || tmux new -s main
#  fi
#fi

# Created by `pipx` on 2026-04-25 20:21:58
export PATH="$PATH:/home/santana/.local/bin"
export PATH=$PATH:$HOME/.local/bin
export PATH="$HOME/.cargo/bin:$PATH"
