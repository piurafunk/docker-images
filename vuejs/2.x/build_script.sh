#!/bin/ash

apk add --no-cache libcap git openssh
su node -c "mkdir ~/.npm-global"
su node -c "npm config set prefix '~/.npm-global'"
su node -c "echo 'export PATH=~/.npm-global/bin:\$PATH' >> ~/.ashrc"
su node -c "npm install --global vue-cli"
setcap 'cap_net_bind_service=+ep' $(which node)
