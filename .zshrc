### Oh my zsh configuration ###

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Path to your oh-my-zsh installation.
export ZSH="/Users/joshua/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"

## Custom plugins ##

# configure nvm plugin
NVM_DIR="/usr/local/opt/nvm"
zstyle ':omz:plugins:nvm' lazy yes

# configure vi-mode plugin
KEYTIMEOUT=1
VI_MODE_SET_CURSOR=true
bindkey -M viins '^V' edit-command-line; bindkey -M vicmd '^V' edit-command-line # remap `vv` to `Ctrl-V`

# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  evalcache
  nvm
  vi-mode
  git
  zsh-syntax-highlighting    
  zsh-autosuggestions
  fzf
  virtualenv
)

# initialize oh-my-zsh
source $ZSH/oh-my-zsh.sh

### User configuration ###

# Load api keys as environment variables from .envkeys
source ~/.envkeys

## Custom Exports ##
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
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

# Cache the result of evals on first run via the evalcache plugin (clear the cache w/ `_evalcache_clear`)
_evalcache pyenv init -
_evalcache rbenv init - zsh

## Personal aliases and functions ##
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
