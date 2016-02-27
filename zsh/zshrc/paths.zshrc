#!/usr/bin/env bash

export RBENV_ROOT="$HOME/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
	export PATH="${RBENV_ROOT}/bin:${PATH}"
	eval "$(rbenv init -)"
fi

export PATH="$PATH:$HOME/.local/bin:vendor/bin"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm