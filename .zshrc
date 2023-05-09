# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load api keys as environment variables from .envkeys
source ~/.envkeys

# Path to your oh-my-zsh installation.
export ZSH="/Users/joshua/.oh-my-zsh"

# Custom Exports
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin":$PATH
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"

export HOMEBREW_BUNDLE_FILE="~/.config/brewfile/Brewfile"
export GIT_EDITOR="nvim"

export BAT_THEME="Catppuccin-mocha"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

ZSH_THEME="powerlevel10k/powerlevel10k"

# lazy load nvm
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  evalcache
  zsh-nvm
  git
  dnf
  zsh-syntax-highlighting    
  zsh-autosuggestions
  fzf
  zsh-vi-mode
  web-search
)

# zsh-vi-mode configuration
ZVM_VI_SURROUND_BINDKEY=classic
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_VI_HIGHLIGHT_BACKGROUND=blue

# fix conflict with fzf in vi-mode
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

source $ZSH/oh-my-zsh.sh

### User configuration ###
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

# Personal aliases
alias python="python3"
alias pip="pip3"
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -I"
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
alias vs='nvim "+lua require(\"resession\").load(vim.fn.getcwd(), { dir = \"dirsession\" })"'

alias fzfp="fzf --preview 'bat --style=numbers --color=always {}'"
alias t="tmux"
alias icat="kitty +kitten icat"

if (( $+commands[exa] )); then
  alias ls="exa --icons"
  alias l="exa -l -H --icons --git"
  alias la="l -a"
  alias lt="l --tree --level=2"
  alias tree="exa --tree --level=3"

  # function to check for file pattern in cwd
  function lag {
    if (($+commands[rg])); then
      exa -l -a -H --icons --git | rg "$@"
    else
      exa -l -a -H --icons --git | grep "$@"
    fi
  }
fi

# function to make directory and cd into it
function mkcd () { mkdir -p -- "$1" && cd -P -- "$1" }

# functions to compile and run c++
function co() { g++ -std=c++17 -O2 -o "${1%.*}" $1 -Wall; }
function run() { co $1 && ./${1%.*} & fg; }

# macos specific hack to enable yanking in zsh-vi-mode (https://github.com/jeffreytse/zsh-vi-mode/issues/19)
function zvm_vi_yank() {
	zvm_yank
	echo ${CUTBUFFER} | pbcopy
	zvm_exit_visual_mode
}

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

# enable zoxide for blazingly fast and intuitive cd
eval "$(zoxide init zsh)"

# Cache the result of eval on first run via the evalcache plugin
# If you update a tool and expect for some reason that it's initialization might have changed, simply clear the cache w/ `_evalcache_clear` and it will be regenerated
if command -v pyenv 1>/dev/null 2>&1; then
  _evalcache pyenv init -
fi
_evalcache rbenv init - zsh
