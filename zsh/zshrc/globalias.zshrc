#!/usr/bin/env bash

# Expand aliases inline - see http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
zle -N globalias 
bindkey " " globalias 
bindkey "^ " magic-space # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches
