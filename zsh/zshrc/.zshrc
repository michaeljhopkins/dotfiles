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

# Correct spelling for commands
setopt correct

# turn off the infernal correctall for filenames
unsetopt correctall

# Base PATH
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin:~/.composer/vendor/bin

if [ -f ~/.ssh/id_rsa ]; then
	if [ $(ssh-add -l | grep -c ".ssh/id_rsa" ) -eq 0 ]; then
		ssh-add ~/.ssh/id_rsa
	fi
fi



# Now that we have $PATH set up and ssh keys loaded, configure zgen.

# start zgen
if [ -f ~/.dotfiles/zsh/zshrc/zgen_setup ]; then
	source ~/.dotfiles/zsh/zshrc/zgen_setup
fi
# end zgen

# Get necessary functions for zshrc
if [ -f ~/.dotfiles/zsh/zshrc/functions.zshrc ]; then
    source ~/.dotfiles/zsh/zshrc/functions.zshrc
fi

# Get aliases and functions
getDotfiles

# Get the various history file configs

if [ -f ~/.dotfiles/zsh/zshrc/history.zshrc ]; then
    source ~/.dotfiles/zsh/zshrc/history.zshrc
fi

export TERM="xterm-256color"
# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# Load globalias stuff
if [ -f ~/.dotfiles/zsh/zshrc/globalias.zshrc ]; then
    source ~/.dotfiles/zsh/zshrc/globalias.zshrc
fi


# Load zstyles

if [ -f ~/.dotfiles/zsh/zshrc/zstyles.zshrc ]; then
    source ~/.dotfiles/zsh/zshrc/zstyles.zshrc
fi

ssh-add -l

export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

# Load any remaninging PATH additions

if [ -f ~/.dotfiles/zsh/zshrc/paths.zshrc ]; then
    source ~/.dotfiles/zsh/zshrc/paths.zshrc
fi

dedupe_path
