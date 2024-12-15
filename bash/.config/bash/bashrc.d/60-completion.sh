#!/usr/bin/env bash

# Enable programmable completion features
if ! shopt -oq posix; then
    if [ -r "/usr/share/bash-completion/bash_completion" ]; then
        . "/usr/share/bash-completion/bash_completion"
    elif [ -r "/usr/local/etc/profile.d/bash_completion.sh" ]; then
        . "/usr/local/etc/profile.d/bash_completion.sh"
    elif [ -r "/etc/bash_completion" ]; then
        . "/etc/bash_completion"
    fi
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
	-o "nospace" \
	-W "$(grep "^Host" ~/.ssh/config | \
	grep -v "[?*]" | cut -d " " -f2 | \
	tr ' ' '\n')" scp sftp ssh

# get the rustup completions
if hash rustup 2>/dev/null; then
	eval "$(rustup completions bash)"
fi

