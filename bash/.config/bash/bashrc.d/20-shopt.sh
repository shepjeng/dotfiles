#!/usr/bin/env bash

set -o noclobber                        # Prevent file overwrite on stdout redirection
                                        # Use `>|` to force redirection to an existing file
#set +h                                  # Disable command hashing
shopt -s checkhash                      # Re-check $PATH on hash failure
#set -o physical                         # resolve symlinks when 'cd'ing
shopt -s autocd 2>/dev/null             # assume 'cd' when trying to exec a directory
shopt -s cdspell                        # autocorrect typos in path names when using `cd`
shopt -s dirspell 2>/dev/null           # autocorrect on directory names to match a glob.
shopt -s checkjobs 2> /dev/null         # print job status on exit
shopt -s checkwinsize                   # update $ROWS/$COLUMNS after command
shopt -s extglob                        # @(…) +(…) etc. globs
shopt -s globstar 2>/dev/null           # the ** glob, recursive globbing, e.g. `echo **/*.txt`
shopt -s nocaseglob                     # case-insensitive globbing (used in pathname expansion)

shopt -u hostcomplete                   # no special treatment for Tab at @
shopt -s no_empty_cmd_completion

set +o histexpand                       # disable !history expansion
shopt -s cmdhist                        # store multi-line commands as single history entry
shopt -s histappend                     # append to $HISTFILE on exit
shopt -s histreedit                     # allow re-editing failed history subst

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."
