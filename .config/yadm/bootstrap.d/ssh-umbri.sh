#!/bin/bash

if [ ! -f ~/.ssh/id_umrbi ]; then
    ssh-keygen -t ed25519 -f ~/.ssh/id_umbri -N ""
fi

if [ ! -f ~/.ssh/config.umbri ]; then
cat > ~/.ssh/config.umbri << EOL
Host github.com
    User lars@umbri.com
    IdentityFile ~/.ssh/id_umbri
EOL
fi
