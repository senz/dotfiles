#!/bin/bash

# if darwin and brew is not installed
if [ "$(uname)" == "Darwin" ] && [ ! -x "$(command -v brew)" ]; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# if chezmoi is installed
if [ -x "$(command -v chezmoi)" ]; then
  echo "Running chezmoi init --apply --verbose"
  chezmoi init --apply --verbose
fi

# in devcontainer/codespace
# REMOTE_CONTAINERS is set
if [ -n "$REMOTE_CONTAINERS" ]; then
  echo "Running in devcontainer/codespace"
fi
