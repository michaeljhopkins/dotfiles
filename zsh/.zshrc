#!/bin/bash
export TERM=xterm-256color;
export COMPLETION_WAITING_DOTS="true"
PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:$HOME/.config/composer/vendor/bin:/usr/bin:/bin:/sbin:$HOME/.bin/$HOME/.local/bin:vendor/bin:/usr/local/opt/php70/bin/php:/opt/local/sbin:/opt/local/bin:/usr/local/share/npm/bin:~/.cabal/bin:~/bin:~/src/gocode/bin:~/.rbenv/bin:/usr/local/var/rbenv/bin
setopt correct
unsetopt correctall
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin
if [[ "$(uname -s)" == "Darwin" ]]; then
	export HOMEBREW_GITHUB_API_TOKEN="fe51fcc13ef45934965a7333336a3fd8ec048e00"
	export PATH=/opt/local/sbin:/Applications/Xcode.app/Contents/Developer/usr/bin:/opt/local/bin:/usr/local/share/npm/bin:~/.cabal/bin:~/bin:~/.rbenv/bin:/usr/local/opt/php70/bin:$PATH
else
	for path_candidate in /opt/local/sbin /opt/local/bin /usr/local/share/npm/bin ~/bin ~/src/gocode/bin
	do
		if [ -d ${path_candidate} ]; then
			export PATH=${PATH}:${path_candidate}
		fi
	done
fi
source ~/.dotfiles/zsh/powerlevel9k.zsh
source ~/.zgen-setup
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
setopt share_history
setopt pushd_ignore_dups
HISTFILE=~/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"
source ~/.zsh_aliases
source ~/.zsh_functions
source /usr/local/bin/virtualenvwrapper.sh
workon py3
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
if [[ -s /usr/local/var/rbenv ]]; then
	export RBENV_VERSION="2.4.2"
	export RBENV_ROOT=/usr/local/var/rbenv
	export PATH="/usr/local/var/rbenv/shims:/usr/local/var/rbenv/bin:$PATH"
	export RBENV_SHELL=zsh
	source '/usr/local/Cellar/rbenv/1.1.0/libexec/../completions/rbenv.zsh'
	command rbenv rehash 2>/dev/null
	rbenv() {
		local command
		command="$1"
		if [ "$#" -gt 0 ]; then
			shift
		fi

		case "$command" in
			rehash|shell)
		eval "$(rbenv "sh-$command" "$@")";;
		*)
		command rbenv "$command" "$@";;
		esac
	}
fi
