#!/usr/bin/env bash
# shellcheck disable=SC2034

# Enable colors in your shell
TERM="xterm-256color"
CLICOLOR=1
S_COLORS="auto"                         # Sysstat/iostat - enable colors (probably on by default, now)

if tput setaf 1 &> /dev/null; then
    CLEAR="$(tput sgr0)"
    DIM="$(tput dim)"
    BOLD="$(tput bold)"
    BLACK="$(tput setaf 0)"
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    MAGENTA="$(tput setaf 5)"
    CYAN="$(tput setaf 6)"
    WHITE="$(tput setaf 7)"
    BRIGHT_BLACK="$(tput setaf 8)"
    BRIGHT_RED="$(tput setaf 9)"
    BRIGHT_GREEN="$(tput setaf 10)"
    BRIGHT_YELLOW="$(tput setaf 11)"
    BRIGHT_BLUE="$(tput setaf 12)"
    BRIGHT_MAGENTA="$(tput setaf 13)"
    BRIGHT_CYAN="$(tput setaf 14)"
    BRIGHT_WHITE="$(tput setaf 15)"
else
    CLEAR="\e[m"
    BOLD="\e1[m"
    BLACK="\e[0;30m"
    RED="\e[0;31m"
    GREEN="\e[0;32m"
    YELLOW="\e[0;33m"
    BLUE="\e[0;34m"
    MAGENTA="\e[0;35m"
    CYAN="\e[0;36m"
    WHITE="\e[0;37m"
    BRIGHT_BLACK="\e[1;30m"
    BRIGHT_RED="\e[1;31m"
    BRIGHT_GREEN="\e[1;32m"
    BRIGHT_YELLOW="\e[1;33m"
    BRIGHT_BLUE="\e[1;34m"
    BRIGHT_MAGENTA="\e[1;35m"
    BRIGHT_CYAN="\e[1;36m"
    BRIGHT_WHITE="\e[1;37m"
fi

