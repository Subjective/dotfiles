# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------
# Zim configuration
# -----------------

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
setopt CORRECT

# Invert + and - meanings so that directories can be selected from stack by number
setopt PUSHDMINUS

# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Use degit instead of git as the default tool to install and update modules.
zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
zstyle ':zim:git' aliases-prefix 'G'

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

# Disable automatic widget re-binding on each precmd
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Set what highlighters will be used.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Colorize completions using default `ls` colors.
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Configure zsh-vim-mode
VIM_MODE_NO_DEFAULT_BINDINGS=true
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_VISUAL="block"

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize zsh-defer.
source ${ZIM_HOME}/modules/zsh-defer/zsh-defer.plugin.zsh

# Initialize modules.
skip_defer=(environment utility powerlevel10k zsh-vim-mode)

# source ${ZIM_HOME}/init.zsh
for zline in ${(f)"$(<$ZIM_HOME/init.zsh)"}; do
  if [[ $zline == source* ]]; then
    skip_source=0
    for skip in "${skip_defer[@]}"; do
      if [[ $zline == *"/modules/$skip/"* ]]; then
        skip_source=1
        break
      fi
    done
    if [[ $skip_source -eq 0 ]]; then
      zsh-defer -c "${zline}"
    else
      eval "${zline}"
    fi
  else
    eval "${zline}"
  fi
done

# Defer evals and cache the results on first run via the evalcache plugin (clear the cache w/ `_evalcache_clear`)
zsh-defer _evalcache zoxide init zsh
zsh-defer _evalcache rtx activate zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

# zsh-history-substring-search
zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

## Vi-Mode ##

# set vi-mode timeout to eliminate lag
KEYTIMEOUT=1
# remap `vv` to `Ctrl-V`
bindkey -M viins '^V' edit-command-line; bindkey -M vicmd '^V' edit-command-line 
# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
# allow ctrl-h, ctrl-w, ctrl-?, ctrl-u for char, word, and line deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line

# ------------------
# User configuration 
# ------------------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#

# load api keys as environment variables from .envkeys
source ~/.envkeys

## Custom Exports ##

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8 # set language environment

# preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
export PATH="$HOME/.local/bin":$PATH
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export HOMEBREW_BUNDLE_FILE="~/.config/brewfile/Brewfile"
export GIT_EDITOR="nvim"
export BAT_THEME="Catppuccin-mocha"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

## Personal aliases and functions ##
alias d='dirs -v | head -10'
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias md='mkdir -p'
alias rd='rmdir'
alias ls="exa --icons"
alias l="exa -l -H --icons --git"
alias la="l -a"
alias lt="l --tree --level=2"
alias tree="exa --tree --level=3"
alias lag='exa -l -a -H --icons --color=always --git | rg'
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -I"
alias python="python3"
alias pip="pip3"
alias lazyvim="NVIM_APPNAME=lazyvim nvim"
alias nvchad="NVIM_APPNAME=nvchad nvim"
alias kickstart="NVIM_APPNAME=kickstart nvim"
alias min="NVIM_APPNAME=min nvim"
alias vi="nvim"
alias dotfiles="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias dot="dotfiles"
alias dots="dot status"
alias dota="dot add"
alias dotc="dot commit"
alias lg="lazygit"
alias lgdot="lazygit --git-dir=$HOME/.cfg --work-tree=$HOME"
alias gitui="gitui -t themes/mocha.ron"
alias brewbackup="brew bundle dump --file=$HOMEBREW_BUNDLE_FILE --force"
alias ypwd='pwd && echo -n `pwd`|pbcopy' # copy and print cwd
alias ywd='echo -n `pwd`|pbcopy' # copy cwd
alias vs='nvim "+lua require(\"resession\").load(vim.fn.getcwd(), { dir = \"dirsession\" })"'
alias fzfp="fzf --preview 'bat --style=numbers --color=always {}'"
alias t="tmux"
alias tks="t kill-server"
alias icat="kitty +kitten icat"
alias s="kitty +kitten ssh"

# function to make directory and cd into it
function mkcd () { mkdir -p -- "$1" && cd -P -- "$1" }

# functions to compile and run c++
function co() { g++ -std=c++17 -O2 -o "${1%.*}" $1 -Wall; }
function run() { co $1 && ./${1%.*} & fg; }

# function to fuzzy find file and open it directly in neovim
v() {
  if [ $# -eq 0 ]; then
    local file
    file=$(fd --type f --hidden --exclude .git | fzf --height=35% --reverse)

    if [ -n "$file" ]; then
      nvim "$file"
    fi
  else
    nvim "$@"
  fi
}

# function to fuzzy find file w/ preview and open it directly in neovim
vp() {
  if [ $# -eq 0 ]; then
    local file
    file=$(fd --type f --hidden --exclude .git | fzf --reverse --preview "bat --style=numbers --color=always {}")

    if [ -n "$file" ]; then
      nvim "$file"
    fi
  else
    nvim "$@"
  fi
}

# function to gauge zsh's startup time
function timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
