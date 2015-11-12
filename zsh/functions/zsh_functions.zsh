#!/bin/zsh
#
# Only including a shebang to trigger Sublime Text to use shell syntax highlighting
#
# Copyright 2006-2015 Joseph Block <jpb@unixorn.net>
#
# BSD licensed, see LICENSE.txt
function masstcpdump () {
	LOOP=1
	for f in `iwconfig 2>/dev/null | grep -o "^wlan[1-9]\+"`; do
		#echo "sudo ifconfig ${f} down"
		`sudo ifconfig ${f} down`
		#echo "sudo iwconfig ${f} mode Monitor"
		`sudo iwconfig ${f} mode Monitor`
		#echo "sudo ifconfig ${f} up"
		`sudo ifconfig ${f} up`
#		if [[ $LOOP -eq 1 ]]; then
#			sudo iw dev $f set channel 1
#		elif [[ $LOOP -eq 2 ]]; then
#			sudo iw dev $f set channel 6
#		else
#			sudo iw dev $f set channel 11
#		fi
		#echo $ARGS
		#echo "sudo tcpdump ${ARGS}"
		sudo tcpdump -s0 -C 50 -W 50 -w "/home/m/pcaps/${f}_${1}" -nni $f -s 0 ip &
#		LOOP=$((LOOP + 1))
	done
}
function networks() {
  sudo service networking $1
  sudo service network-manager $1
}

function exists() {
  which $1 &> /dev/null
}

# from cads@ooyala.com
function ff() {
  find . -type f -iname '*'$@'*' -ls
}

# Find things in that enormous command history file
function hgrep40 {
  history | egrep --color -i "$@" | tail -40
}

function hgrep {
  history | grep -i "$@" | tail -20
}

function hgrep_full {
  history | egrep --color -i "$@"
}

function envgrep() {
  printenv | grep -i "$@"
}

# From Dan Ryan's blog - http://danryan.co/using-antigen-for-zsh.html
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

# From commandlinefu.com
function watch() { t=$1; shift; while test :; do clear; date=$(date); echo -e "Every $ts: $@ \t\t\t\t $date"; $@; sleep $t; done }

# scp file to machine you're sshing into this machine from
function mecp () {
  scp "$@" ${SSH_CLIENT%% *}:~/Downloads/;
}

function calc() {
  awk "BEGIN{ print $* }" ;
}

function procs_for_path() {
  for pid in $(lsof "$@" | cut -d' ' -f 3 | sort | uniq)
  do
    ps -f -p $pid
  done
}

# Begin sysadvent2011 functions
function _awk_col() {
  echo "$1" | egrep -v '^[0-9]+$' || echo "\$$1"
}

function sum() {
  [ "${1#-F}" != "$1" ] && SP=${1} && shift
  [ "$#" -eq 0 ] && set -- 0
  key="$(_awk_col "$1")"
  awk $SP "{ x+=$key } END { printf(\"%d\n\", x) }"
}

function sumby() {
  [ "${1#-F}" != "$1" ] && SP=${1} && shift
  [ "$#" -lt 0 ] && set -- 0 1
  key="$(_awk_col "$1")"
  val="$(_awk_col "$2")"
  awk $SP "{ a[$key] += $val } END { for (i in a) { printf(\"%d %s\\n\", a[i], i) } }"
}

function countby() {
  [ "${1#-F}" != "$1" ] && SP=${1} && shift
  [ "$#" -eq 0 ] && set -- 0
  key="$(_awk_col "$1")"
  awk $SP "{ a[$key]++ } END { for (i in a) { printf(\"%d %s\\n\", a[i], i) } }"
}
# end sysadvent

# ssh helper
function rmhost () {
  perl -i -ne "print unless $1 .. $1" ~/.ssh/known_hosts;
}

get_nr_jobs() {
  jobs | wc -l
}

get_load() {
  uptime | awk '{print $11}' | tr ',' ' '
}

function bash_repeat() {
  n=$1
  shift
  while [ $(( n -= 1 )) -ge 0 ]
  do
      "$@"
  done
}

function authme {
  ssh "$1" 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_dsa.pub
}

function mtr_url {
  host=$(ruby -ruri -e "puts (URI.parse('$1').host or '$1')")
  sudo mtr -t $host
}

function jsoncurl() {
  curl "$@" | python -m json.tool
}

# Recursively touch, e.g. touch + mkdir -p
# so files can easily be created at depth
#
canhaz() {
  mkdir -p -- "${1%/*}" && touch -- "$1"
}

canhaz-script() {
  canhaz "${1}" && chmod +x "$1"
}

pong() {
  ping -c 10 "$@"
}

fix_tmux_ssh_agent() {
  for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
    if (tmux show-environment | grep "^${key}" > /dev/null); then
      value=$(tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//")
      export ${key}="${value}"
    fi
  done
}

show_terminal_colors() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

# Batch change extension from $1 to $2
chgext() {
  for file in *.$1
  do
    mv $file $(echo $file | sed "s/\(.*\.\)$1/\1$2/")
  done
}

# Probe a /24 for hosts
scan24() {
  nmap -sP ${1}/24
}

# Netjoin - Block until a network connection is obtained.
# Originally from https://github.com/bamos/dotfiles/blob/master/.funcs
nj() {
  while true; do
    ping -c 1 8.8.8.8 &> /dev/null && break
    sleep 1
  done
}

# Pretty JSON
# from: https://coderwall.com/p/hwu5uq?i=9&p=1&q=sort%3Ascore+desc&t%5B%5D=zsh
function pjson {
  if [ $# -gt 0 ];
    then
    for arg in $@
    do
      if [ -f $arg ];
        then
        less $arg | python -m json.tool
      else
        echo "$arg" | python -m json.tool
      fi
    done
  fi
}

# lists zombie processes
function zombie() {
  ps aux | awk '{if ($8=="Z") { print $2 }}'
}

# get the content type of an http resource
# from https://github.com/jleclanche/dotfiles/blob/master/.zshrc
function htmime {
  if [[ -z $1 ]]; then
    print "USAGE: htmime <URL>"
    return 1
  fi
  mime=$(curl -sIX HEAD $1 | sed -nr "s/Content-Type: (.+)/\1/p")
  print $mime
}

