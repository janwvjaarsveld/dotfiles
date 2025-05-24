#!/bin/bash
# bootstrap.sh - Always get the latest interactive installer
curl -fsSL https://raw.githubusercontent.com/janwvjaarsveld/dotfiles/HEAD/install.sh -o /tmp/install.sh
chmod +x /tmp/install.sh
exec /tmp/install.sh "$@"
