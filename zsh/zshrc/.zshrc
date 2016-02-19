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

# Conditional PATH additions
for path_candidate in /opt/local/sbin \
  /Applications/Xcode.app/Contents/Developer/usr/bin \
  /opt/local/bin \
  /usr/local/share/npm/bin \
  ~/.cabal/bin \
  ~/.rbenv/bin \
  ~/bin \
  ~/src/gocode/bin
do
  if [ -d ${path_candidate} ]; then
    export PATH=${PATH}:${path_candidate}
  fi
done

# Fun with SSH
if [ $(ssh-add -l | grep -c "The agent has no identities." ) -eq 1 ]; then
  if [[ "$(uname -s)" == "Darwin" ]]; then
    # We're on OS X. Try to load ssh keys using pass phrases stored in
    # the OSX keychain.
    #
    # You can use ssh-add -K /path/to/key to store pass phrases into
    # the OSX keychain
    ssh-add -k
  fi
fi

if [ -f ~/.ssh/id_rsa ]; then
  if [ $(ssh-add -l | grep -c ".ssh/id_rsa" ) -eq 0 ]; then
    ssh-add ~/.ssh/id_rsa
  fi
fi

if [ -f ~/.ssh/id_dsa ]; then
  if [ $(ssh-add -L | grep -c ".ssh/id_dsa" ) -eq 0 ]; then
    ssh-add ~/.ssh/id_dsa
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

if [ -f ~/.dotfiles/zsh/functions/zsh.functions ]; then
    source ~/.dotfiles/zsh/functions/zsh.functions
fi

if [ -f ~/.dotfiles/zsh/aliases/zsh.aliases ]; then
    source ~/.dotfiles/zsh/aliases/zsh.aliases
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
  # We're on osx
  [ -f ~/.osx_aliases ] && source ~/.osx_aliases
  if [ -d ~/.osx_aliases.d ]; then
    for alias_file in ~/.osx_aliases.d/*
    do
      source $alias_file
    done
  fi
fi
# Get the various history file configs

if [ -f ~/.dotfiles/zsh/zshrc/history.zshrc ]; then
    source ~/.dotfiles/zsh/zshrc/history.zshrc
fi

export TERM="xterm-256color"
# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# Expand aliases inline - see http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
globalias() {
   if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
     zle _expand_alias
     zle expand-word
   fi
   zle self-insert
}

zle -N globalias

bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches

echo
echo "Current SSH Keys:"
ssh-add -l
echo


# Load zstyles

if [ -f ~/.dotfiles/zsh/zshrc/zstyles.zshrc ]; then
    source ~/.dotfiles/zsh/zshrc/zstyles.zshrc
fi

# Load any remaninging PATH additions

if [ -f ~/.dotfiles/zsh/zshrc/paths.zshrc ]; then
    source ~/.dotfiles/zsh/zshrc/paths.zshrc
fi


# In case a plugin adds a redundant path entry, remove duplicate entries
# from PATH
#
# This snippet is from Mislav Marohnić <mislav.marohnic@gmail.com>'s
# dotfiles repo at https://github.com/mislav/dotfiles

dedupe_path() {
  typeset -a paths result
  paths=($path)

  while [[ ${#paths} -gt 0 ]]; do
    p="${paths[1]}"
    shift paths
    [[ -z ${paths[(r)$p]} ]] && result+="$p"
  done

  export PATH=${(j+:+)result}
}

dedupe_path
# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV"
