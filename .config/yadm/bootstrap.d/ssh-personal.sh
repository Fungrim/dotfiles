#!/bin/bash

if [ ! -f ~/.ssh/id_personal ]; then
    ssh-keygen -t ed25519 -f ~/.ssh/id_personal -N ""
fi

if [ ! -f ~/.ssh/config.personal ]; then
cat > ~/.ssh/config.personal << EOL
Host github.com
    User contact@larsan.net
    IdentityFile ~/.ssh/id_personal
EOL
fi

if  [ -f ~/.ssh/config ]; then
    rm ~/.ssh/config
fi

ln -s ~/.ssh/config.personal ~/.ssh/config
