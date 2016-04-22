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
if [ -f $HOME/.ssh/awskeypair.pem ]; then
  if [ $(ssh-add -l | grep -c ".ssh/awskeypair.pem" ) -eq 0 ]; then
    ssh-add $HOME/.ssh/awskeypair.pem
  fi
fi

if [ -f $HOME/.dotfiles/zsh/functions/directory-history.plugin.zsh ]; then
  source ~/.dotfiles/zsh/functions/directory-history.plugin.zsh
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
# Bind up/down arrow keys to navigate through your history
#bindkey '\e[A' directory-history-search-backward
#bindkey '\e[B' directory-history-search-forward

# Bind CTRL+k and CTRL+j to substring search
bindkey '^j' history-substring-search-up
bindkey '^k' history-substring-search-down
zgen load caiogondim/bullet-train-oh-my-zsh-theme bullet-train

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

dedupe_path
