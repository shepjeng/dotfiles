#!/usr/bin/env bash
# shellcheck disable=SC2034

# Automatically trim long paths in the prompt (requires Bash 5.x)
PROMPT_DIRTRIM=5

## Determine if the terminal supports color
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=no
fi

USER_STYLE="\[${BRIGHT_CYAN}\]"
HOST_STYLE="\[${CYAN}\]"
GIT_STYLE="\[${GREEN}\]"
SYMBOL_STYLE="\[${CLEAR}\]"
SIGN_STYLE="\[${YELLOW}\]"

# Highlight the brackets when logged in as root.
if [ "${USER}" = "root" ]; then
    SYMBOL_STYLE="\[${MAGENTA}\]"
    SIGN_STYLE="\[${BRIGHT_MAGENTA}\]"
fi

if [ -f "$XDG_CONFIG_HOME/bash/.prompt-green" ]; then
    USER_STYLE="\[${BRIGHT_GREEN}\]"
    HOST_STYLE="\[${GREEN}\]"
    GIT_STYLE="\[${YELLOW}\]"
elif [ -f "$XDG_CONFIG_HOME/bash/.prompt-yellow" ]; then
    USER_STYLE="\[${BRIGHT_YELLOW}\]"
    HOST_STYLE="\[${YELLOW}\]"
    GIT_STYLE="\[${BRIGHT_GREEN}\]"
fi

# Highlight some symbols when connected via ssh.
if [ "${SSH_TTY}" ]; then
    :
else
    :
fi

# Set the prompt based on color support
GIT_PS1='$(__git_ps1 " %s") '

if [ "$color_prompt" = yes ]; then
    PS1="${SYMBOL_STYLE}["
    PS1+="${USER_STYLE}\u"              # username
    PS1+="\[${CLEAR}\]@"
    PS1+="${HOST_STYLE}\h"              # host
    PS1+="${SYMBOL_STYLE}]"
    PS1+="\[${BRIGHT_GREEN}\]\w"        # working directory full path
    PS1+="${GIT_STYLE}${GIT_PS1}"
    PS1+="${SIGN_STYLE}\\$\[${CLEAR}\] "
    PS2="\[${BRIGHT_YELLOW}\]  »\[${CLEAR}\] ";
else
    PS1="[\u@\h]\w \\$ "
    PS2="  » ";
fi
unset color_prompt

export PS1
export PS2

