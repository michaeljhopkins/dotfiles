#!/usr/bin/env bash

export PATH="/home/m/.nvm:$PATH"
export NVM_DIR="/home/m/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
	export PATH="${RBENV_ROOT}/bin:${PATH}"
	eval "$(rbenv init -)"
fi

export PATH="$PATH:/home/m/.local/bin:vendor/bin"
export MSF_DATABASE_CONFIG="/opt/metasploit-framework/config/database.yml"
export PATH="$PATH:/home/m/anaconda/bin/pip"