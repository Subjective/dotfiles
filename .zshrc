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
zstyle ':zim:git' aliases-prefix 'g'

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

# Disable automatic widget re-binding on each precmd
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Set what highlighters will be used.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Colorize completions using default `ls` colors. 
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

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
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# Initialize zsh-defer.
source ${ZIM_HOME}/modules/zsh-defer/zsh-defer.plugin.zsh

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

# ------------------
# User configuration 
# ------------------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#

## Plugin configuration ##

# configure vi-mode
KEYTIMEOUT=1
bindkey -M viins '^V' edit-command-line; bindkey -M vicmd '^V' edit-command-line # remap `vv` to `Ctrl-V`

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
 # Use beam shape cursor for each new prompt.
precmd_functions+=(echo -ne '\e[5 q')

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

## Eval statements ##

# defer evals and cache the results on first run via the evalcache plugin (clear the cache w/ `_evalcache_clear`)
zsh-defer _evalcache fnm env --use-on-cd
zsh-defer _evalcache pyenv init -
zsh-defer _evalcache rbenv init - zsh
zsh-defer _evalcache zoxide init zsh


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
alias rd=rmdir
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
alias vi="nvim"
alias dotfiles="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias dot="dotfiles"
alias dots="dot status"
alias dota="dot add"
alias dotc="dot commit"
alias lg="lazygit"
alias lgdot="lazygit --git-dir=$HOME/.cfg --work-tree=$HOME"
alias brewbackup="brew bundle dump --file=$HOMEBREW_BUNDLE_FILE --force"
alias ypwd='pwd && echo -n `pwd`|pbcopy' # copy and print cwd
alias ywd='echo -n `pwd`|pbcopy' # copy cwd
alias v='fd --type f --hidden --exclude .git | fzf --height=35% --reverse | tr \\n \\0 | xargs -0 nvim'
alias vp='fd --type f --hidden --exclude .git | fzf --reverse --preview "bat --style=numbers --color=always {}" | tr \\n \\0 | xargs -0 nvim'
alias vs='nvim "+SessionManager load_current_dir_session"'
# alias vs='nvim "+lua require(\"resession\").load(vim.fn.getcwd(), { dir = \"dirsession\" })"'
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

# function to interactively load nvim configs via fzf
function nvims() {
  items=("default" "nvchad" "lazyvim" "kickstart" )
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=25% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  else
    config="$config"
  fi
  NVIM_APPNAME=$config nvim $@
}

# function to guage zsh's startup time
function timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
