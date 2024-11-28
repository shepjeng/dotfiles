#!/usr/bin/env bash

# Print each PATH entry on a separate line
path()
{
    echo -e "${PATH//:/\\n}"
}

hello()
{
    cat <<-EOF
   (__)
\\\\\\'',)
  \\/  \\ ^
  .\\._/_)  Hello ${BOLD}$USER${CLEAR} (${SSH_CLIENT%% *}). This is ${BOLD}$HOSTNAME${CLEAR}!
EOF
}
