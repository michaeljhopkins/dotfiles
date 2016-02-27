#!/usr/bin/env bash
# Copyright 2006-2015 Joseph Block <jpb@apesseekingknowledge.net>
#
# BSD licensed, see LICENSE.txt

# Set this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
export COMPLETION_WAITING_DOTS="false"
export TERM="xterm-256color"

# Correct spelling for commands
setopt correct

# turn off the infernal correctall for filenames
unsetopt correctall

# Base PATH
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin:$HOME/.composer/vendor/bin

if [ -f $HOME/.ssh/id_rsa ]; then
	if [ $(ssh-add -l | grep -c ".ssh/id_rsa" ) -eq 0 ]; then
		ssh-add $HOME/.ssh/id_rsa
	fi
fi




# Now that we have $PATH set up and ssh keys loaded, configure zgen.

# start zgen
if [ -f $HOME/.dotfiles/zsh/zshrc/zgen_setup ]; then
	source $HOME/.dotfiles/zsh/zshrc/zgen_setup
fi
# end zgen

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

export TERM="xterm-256color"
# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# Load globalias stuff
if [ -f $HOME/.dotfiles/zsh/zshrc/globalias.zshrc ]; then
    source $HOME/.dotfiles/zsh/zshrc/globalias.zshrc
fi


# Load zstyles

if [ -f $HOME/.dotfiles/zsh/zshrc/zstyles.zshrc ]; then
    source $HOME/.dotfiles/zsh/zshrc/zstyles.zshrc
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
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

. /usr/local/bin/virtualenvwrapper.sh

workon main

BULLETTRAIN_VIRTUALENV_BG=yellow
BULLETTRAIN_NVM_SHOW=true
BULLETTRAIN_NVM_BG=green
BULLETTRAIN_GIT_PROMPT_CMD=\${\$(git_prompt_info)//\\//\ \ }
BULLETTRAIN_TIME_12HR=true
BULLETTRAIN_TIME_BG=black
BULLETTRAIN_TIME_FG=yellow
BULLETTRAIN_DIR_BG=blue
BULLETTRAIN_RUBY_BG=magenta
BULLETTRAIN_VIRTUALENV_PREFIX="🐍 "
BULLETTRAIN_NVM_PREFIX="⬡ "
BULLETTRAIN_RUBY_PREFIX="♦ "

dedupe_path
