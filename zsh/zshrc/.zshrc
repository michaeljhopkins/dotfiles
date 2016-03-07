#!/usr/bin/env bash

export TERM=xterm-256color

export RBENV_ROOT="$HOME/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi

export PATH="$PATH:$HOME/.local/bin:vendor/bin"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
rbenv shell 2.2.3

export WORKON_HOME=$HOME/.virtualenvs

POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%{%F{249}%}\u250f"
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%{%F{249}%}\u2517%{%F{default}%} "
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_VIRTUAL_ENV_DISABLE_PROMPT=false
POWERLEVEL9K_DIR_HOME_BACKGROUND="black"
POWERLEVEL9K_DIR_HOME_FOREGROUND="249"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="249"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="black"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="249"
POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="black"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
POWERLEVEL9K_NVM_BACKGROUND="black"
POWERLEVEL9K_NVM_FOREGROUND="249"
POWERLEVEL9K_NVM_VISUAL_IDENTIFIER_COLOR="green"
POWERLEVEL9K_RBENV_BACKGROUND="black"
POWERLEVEL9K_RBENV_FOREGROUND="249"
POWERLEVEL9K_RBENV_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="black"
POWERLEVEL9K_VIRTUALENV_FOREGROUND="249"
POWERLEVEL9K_VIRTUALENV_VISUAL_IDENTIFIER_COLOR="yellow"
POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="black"
POWERLEVEL9K_LOAD_WARNING_BACKGROUND="black"
POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="black"
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="249"
POWERLEVEL9K_LOAD_WARNING_FOREGROUND="249"
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="249"
POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="yellow"
POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"
POWERLEVEL9K_RAM_BACKGROUND="black"
POWERLEVEL9K_RAM_FOREGROUND="249"
POWERLEVEL9K_RAM_ELEMENTS=(ram_free)
POWERLEVEL9K_BATTERY_LOW_BACKGROUND="black"
POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND="black"
POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND="black"
POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND="black"
POWERLEVEL9K_BATTERY_LOW_FOREGROUND="249"
POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND="249"
POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND="249"
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND="249"
POWERLEVEL9K_BATTERY_LOW_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_BATTERY_CHARGING_VISUAL_IDENTIFIER_COLOR="yellow"
POWERLEVEL9K_BATTERY_CHARGED_VISUAL_IDENTIFIER_COLOR="green"
POWERLEVEL9K_BATTERY_DISCONNECTED_VISUAL_IDENTIFIER_COLOR="249"
POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S} \UE12E"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(nvm rbenv virtualenv load ram_joined battery time)

export DEFAULT_USER="$USER"

# === ZGEN stuff ===
if [ !  -f $HOME/.zgen/zgen.zsh ]; then
    echo "Zgen not found, bootstrapping."
    mkdir -p $HOME/.zgen
    curl -L https://raw.githubusercontent.com/tarjoilija/zgen/master/zgen.zsh > $HOME/.zgen/zgen.zsh
fi

# Base PATH
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin:$HOME/.composer/vendor/bin

if [ -f $HOME/.ssh/id_rsa ]; then
	if [ $(ssh-add -l | grep -c ".ssh/id_rsa" ) -eq 0 ]; then
		ssh-add $HOME/.ssh/id_rsa
	fi
fi


if [ ! -f ~/zgen/zgen.zsh ]; then
  pushd ~
  git clone git@github.com:tarjoilija/zgen.git
  popd
fi
source ~/zgen/zgen.zsh

zgen oh-my-zsh
zgen oh-my-zsh plugins/pip 
zgen oh-my-zsh plugins/sudo 
zgen oh-my-zsh plugins/github 
zgen oh-my-zsh plugins/python 
zgen oh-my-zsh plugins/vagrant 
zgen oh-my-zsh plugins/cp 
zgen oh-my-zsh plugins/extract 
zgen oh-my-zsh plugins/bower 
zgen oh-my-zsh plugins/node 
zgen oh-my-zsh plugins/nvm 
zgen oh-my-zsh plugins/npm 
zgen oh-my-zsh plugins/composer 
zgen oh-my-zsh plugins/rbenv 
zgen oh-my-zsh plugins/gem

zgen load t413/zsh-background-notify
zgen load zsh-users/zsh-syntax-highlighting
zgen load zsh-users/zsh-history-substring-search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
zgen load bhilburn/powerlevel9k powerlevel9k

zgen load zsh-users/zsh-completions src
zgen save
# https://github.com/zsh-users/zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
#source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Get necessary functions for zshrc
if [ -f $HOME/.dotfiles/zsh/zshrc/functions.zshrc ]; then
  source $HOME/.dotfiles/zsh/zshrc/functions.zshrc
fi

# Get aliases and functions
getDotfiles

# Get the various history file configs

if [ -f $HOME/.dotfiles/zsh/zshrc/history.zshrc ]; then
  source $HOME/.dotfiles/zsh/zshrc/history.zshrc
fi

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# Load globalias stuff
if [ -f $HOME/.dotfiles/zsh/zshrc/globalias.zshrc ]; then
  source $HOME/.dotfiles/zsh/zshrc/globalias.zshrc
fi

ssh-add -l

export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

# Load any remaninging PATH additions

if [ -f $HOME/.dotfiles/zsh/zshrc/paths.zshrc ]; then
  source $HOME/.dotfiles/zsh/zshrc/paths.zshrc
fi


# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=($(COMP_WORDS="$words[*]" COMP_CWORD=$(( cword-1 )) PIP_AUTO_COMPLETE=1 $words[1]))
}

compctl -K _pip_completion pip
export COLORTERM="terminator"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)

source  ~/.dotfiles/zsh/theme/powerlevel9k/powerlevel9k.zsh-theme
dedupe_path
