#!/usr/bin/env bash

globalias() {
	if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
		zle _expand_alias
		zle expand-word
	fi
	zle self-insert
}


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

getDotfiles() {
	if [ -d ~/.dotfiles/zsh/functions ]; then
		for function in ~/.dotfiles/zsh/functions/*
		do
			source "$function"
		done
	fi
	if [ -d ~/.dotfiles/zsh/aliases ]; then
		for alias in ~/.dotfiles/zsh/aliases/*
		do
			source "$alias"
		done
	fi
}