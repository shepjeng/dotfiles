#!/usr/bin/env bash

alias vim="nvim -p"
alias vimdiff="nvim -d"

# Verbosity and settings that you pretty much just always are going to want.
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
# alias rm="trash"

#export LS_COLORS="no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:"
alias ls="ls -F --color"
alias ll="ls -lF"
alias la="ls -lFa"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias diff="diff --color=auto"

alias less="less -r"

alias ip="ip -c"
alias net-ls="netstat -lntp"
alias net-ll="ss -plat"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# alias clear="tput clear"
# alias reset="tput reset"
alias hide-cursor="tput civis"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Switch to a temporary directory
alias cdtmp="cd $(mktemp -d)"

# Generate random string `rand-str 10`
alias rand-str="openssl rand -base64"

# Convenient `open` and `trash` commands for Linux and macOS
if [[ "$OSTYPE" =~ linux ]]; then
    command -v xdg-open > /dev/null && alias open='xdg-open'
    command -v gio > /dev/null && alias trash='gio trash'
fi

alias week="date +%V"
alias camera="ffplay /dev/video0"
