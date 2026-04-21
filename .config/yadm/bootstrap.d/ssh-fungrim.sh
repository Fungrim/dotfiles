#!/bin/bash

if [ ! -f ~/.ssh/id_fungrim ]; then
    ssh-keygen -t ed25519 -f ~/.ssh/id_fungrim -N ""
fi

if [ ! -f ~/.ssh/config.fungrim ]; then
cat > ~/.ssh/config.fungrim << EOL
Host github.com
    User lars@fungrim.com
    IdentityFile ~/.ssh/id_fungrim
EOL
fi

