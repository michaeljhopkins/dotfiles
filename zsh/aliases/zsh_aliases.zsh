#!/usr/bin/env bash
#
# Only including a shebang to trigger Sublime Text to use shell syntax highlighting
#
# Copyright 2006-2015 Joseph Block <jpb@unixorn.net>
#
# BSD licensed, see LICENSE.txt

export GOPATH=~/gocode

if [[ "$(uname -s)" == "Linux" ]]; then
  # we're on linux
  alias l-d="ls -lFad"
  alias l="ls -laF"
  alias ll="ls -lFa | TERM=vt100 less"
fi

export CVS_RSH=ssh

alias historysummary="history | awk '{a[\$2]++} END{for(i in a){printf \"%5d\t%s\n\",a[i],i}}' | sort -rn | head"

# A couple of different external IP lookups depending on which is down.
alias external_ip="curl -s icanhazip.com"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

# Show laptop's IP addresses
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# My typical tyops.
alias gerp="grep"
alias grep-i="grep -i"
alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'
alias grepi="grep -i"
alias knfie="knife"
alias maek="make"
alias psax="ps ax"
alias pswax="ps wax"
alias psxa="ps ax"
alias raek="rake"
alias tartvf="tar tvf"
alias tartvzf="tar tvzf"
alias tarxvf="tar xvf"
alias ..="cd .."
alias ...="cd ../.."
alias art="php artisan"
alias c="composer"
alias larafresh="composer dump && rm -rf bootstrap/cache/* storage/framework/sessions/* storage/framework/cache/* storage/framework/views/* vendor node_modules && composer install && php artisan clear-compiled  && php artisan ide-helper:generate && php artisan optimize && php artisan migrate:reload"
alias asb="cd ~/Projects/Web/asb-client"
alias cookie="sudo java -jar /home/m/Pentest/network/sidejacking/CookieCadger-1.06.jar"
alias jam="sudo python /home/m/Pentest/wireless/wifijammer/wifijammer.py -p 5 -t .00001 -d"
alias net-creds="sudo python /home/m/Pentest/network/net-creds/net-creds.py"
alias k="k -Ah"
alias ls="k"
alias mycli='mycli -h 127.0.0.1 -u root -p secret'
