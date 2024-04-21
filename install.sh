#!/bin/bash

CHEZMOI_USER="senz"

if [ -n "$REMOTE_CONTAINERS" ]; then
  echo "Running in remote container"
  # in devcontainer we assume that the dotfiles are pre-downloaded and located in ~/dotfiles
  # we pass the --no-tty flag because install invocation is non-interactive, so we handle this case in template by setting the default value
  # sourceDir will be set to ~/dotfiles
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --debug --no-tty -S ~/dotfiles --apply
else
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $CHEZMOI_USER
fi
