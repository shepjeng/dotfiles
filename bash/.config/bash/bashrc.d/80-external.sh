#!/usr/bin/env bash

if [ -s "${CARGO_HOME:-$HOME/.cargo}/env" ]; then
    source "${CARGO_HOME:-$HOME/.cargo}/env"
fi

if [ -s "${rvm_path:-$HOME/.rvm}/scripts/rvm" ]; then 
    source "${rvm_path:-$HOME/.rvm}/scripts/rvm"
fi

if [ -s "${XDG_STATE_HOME}/nix/profile/etc/profile.d/nix.sh" ]; then
    source "${XDG_STATE_HOME}/nix/profile/etc/profile.d/nix.sh"
fi

