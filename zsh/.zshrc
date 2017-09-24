#!/bin/bash
export TERM=xterm-256color;
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
export COMPLETION_WAITING_DOTS="true"
PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:$HOME/.config/composer/vendor/bin:/usr/bin:/bin:/sbin:$HOME/.bin/$HOME/.local/bin:vendor/bin:/usr/local/opt/php70/bin/php:/opt/local/sbin:/opt/local/bin:/usr/local/share/npm/bin:~/.cabal/bin:~/bin:~/src/gocode/bin:~/.rbenv/bin:/usr/local/var/rbenv/bin

# Correct spelling for commands
setopt correct

# turn off the infernal correctall for filenames
unsetopt correctall

# Base PATH
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin


if [[ "$(uname -s)" == "Darwin" ]]; then
	export HOMEBREW_GITHUB_API_TOKEN="fe51fcc13ef45934965a7333336a3fd8ec048e00"
  # Conditional PATH additions
  export PATH="$(brew --prefix homebrew/php/php70)/bin:$PATH"
  for path_candidate in /opt/local/sbin /Applications/Xcode.app/Contents/Developer/usr/bin /opt/local/bin /usr/local/share/npm/bin ~/.cabal/bin ~/bin ~/src/gocode/bin ~/.rbenv/bin
  do
    if [ -d ${path_candidate} ]; then
      export PATH=${PATH}:${path_candidate}
    fi
  done
else
  # Conditional PATH additions
  for path_candidate in /opt/local/sbin /opt/local/bin /usr/local/share/npm/bin ~/bin ~/src/gocode/bin
  do
    if [ -d ${path_candidate} ]; then
      export PATH=${PATH}:${path_candidate}
    fi
  done
fi

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
if [ -f ~/.dotfiles/zsh/powerlevel9k.zsh ]; then
  source ~/.dotfiles/zsh/powerlevel9k.zsh
fi

# start zgen
if [ -f ~/.zgen-setup ]; then
  source ~/.zgen-setup
fi
# end zgen

zgen load bhilburn/powerlevel9k powerlevel9k
# Bullet train prompt setup
#zgen load oskarkrawczyk/honukai-iterm-zsh honukai

# set some history options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt EXTENDED_HISTORY

# Share your history across all your terminal windows
setopt share_history
#setopt noclobber

# set some more options
setopt pushd_ignore_dups
#setopt pushd_silent

# Keep a ton of history.
HISTFILE=~/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

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

# Customize to your needs...
# Customize to your needs...
# Stuff that works on bash or zsh
if [ -r ~/.sh_aliases ]; then
  source ~/.sh_aliases
fi

# Stuff only tested on zsh, or explicitly zsh-specific
if [ -r ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

if [ -r ~/.zsh_functions ]; then
  source ~/.zsh_functions
fi

zstyle ":completion:*" auto-description "specify: %d"
zstyle ":completion:*" completer _expand _complete _correct _approximate
zstyle ":completion:*" format "Completing %d"
zstyle ":completion:*" group-name ""
zstyle ":completion:*" menu select=2
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*" list-colors ""
zstyle ":completion:*" list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ":completion:*" matcher-list "" "m:{a-z}={A-Z}" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=* l:|=*"
zstyle ":completion:*" menu select=long
zstyle ":completion:*" select-prompt %SScrolling active: current selection at %p%s
zstyle ":completion:*" verbose true

zstyle ":completion:*:*:kill:*:processes" list-colors "=(#b) #([0-9]#)*=0=01;31"
zstyle ":completion:*:kill:*" command "ps -u $USER -o pid,%cpu,tty,cputime,cmd"

# Load any custom zsh completions we've installed
if [ -d ~/.zsh-completions ]; then
  for completion in ~/.zsh-completions/*
  do
    source "$completion"
  done
fi
if [[ "$(uname -s)" == "Darwin" ]]; then
  if [ -f "$(brew --prefix nvm)/nvm.sh" ]; then
    source "$(brew --prefix nvm)/nvm.sh";
  fi
else
  if [[ -s $HOME/.nvm/nvm.sh ]]; then
    . ~/.nvm/nvm.sh
  fi
fi

if [[ -s /usr/local/var/rbenv ]]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi

#which virtualenvwrapper.sh > /dev/null 2>&1 && source $(which virtualenvwrapper.sh)
#command -v workon > /dev/null 2>&1 && workon py3

if [ -d /usr/local/bin/virtualenvwrapper.sh ]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi
zgen load bhilburn/powerlevel9k powerlevel9k
if [[ "$(uname -s)" == "Darwin" ]]; then
  if [ -s $HOME/.iterm2_shell_integration.zsh ]; then
    source "$HOME/.iterm2_shell_integration.zsh"
  fi
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
