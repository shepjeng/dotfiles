#!/usr/bin/env bash
# shellcheck disable=SC2139

alias vim="nvim -p"
alias vimdiff="nvim -d"

# Verbosity and settings that you pretty much just always are going to want.
alias cp="cp -iv"
alias mv="mv -iv ${GNU:+--one-file-system}"
alias rm="rm -iv"
# alias rm="trash"

alias ls="\ls -F --color ${GNU:+--group-directories-first --time-style='+%Y-%m-%d %H:%M'}"
alias ll="ls -lh"
alias la="ls -lhA"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep="grep --color=auto"
alias fgrep="grep --color=auto -F"
alias egrep="grep --color=auto -E"
alias diff="diff --color=auto"
alias ip="ip --color=auto"
alias dmesg="dmesg --color=auto -e -x"
alias which="which -a"

alias fd="fd --strip-cwd-prefix --hidden --follow --exclude .git"

alias net-ls="netstat -lntp"
alias net-ll="ss -plat"
alias net-ports="lsof -PiTCP -sTCP:LISTEN"

# Reload the shell (i.e. invoke as a login shell)
alias reload='exec "$SHELL" -l'

# alias clear="tput clear"
# alias reset="tput reset"
alias hide-cursor="tput civis"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Switch to a temporary directory
alias cdtmp='cd "$(mktemp -d)"'

# Convenient `open` and `trash` commands for Linux and macOS
if [[ "$OSTYPE" =~ linux ]]; then
    command -v xdg-open > /dev/null && alias open="xdg-open"
    command -v gio > /dev/null && alias trash="gio trash"
fi

alias week="date +%V"
alias camera="ffplay /dev/video0"

