#!/bin/bash

CHEZMOI_USER="senz"

install_homebrew() {
  if [ ! -x "$(command -v brew)" ]; then
    xcode-select --install

    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

install_chezmoi() {
  if [ ! -x "$(command -v chezmoi)" ]; then
    echo "Installing chezmoi"

    if [ "$(uname)" == "Darwin" ]; then
      brew install chezmoi
    elif [ "$(uname)" == "Linux" ]; then
      sh -c "$(curl -fsLS get.chezmoi.io)"
    fi
  fi
}

prepare_devcontainer() {
  echo "Running in devcontainer/codespace"
  if [ ! -f ~/.config/chezmoi/chezmoi.yaml ]; then
    mkdir -p $HOME/.config/chezmoi
    echo "pre-populating config from gitconfig"
    cat <<EOF > $HOME/.config/chezmoi/chezmoi.yaml
---
data:
  fullname: $(git config --get user.name)
  email: $(git config --get user.email)
  recipient: $(git config --get user.signingkey)
EOF
  fi
}

run_chezmoi() {
  if [ -n "$REMOTE_CONTAINERS" ]; then
    # we have all the files in the dotfiles directory already
    # so we can just run chezmoi init with the dotfiles directory and then purge
    chezmoi init --debug --no-tty -S ~/dotfiles --apply --verbose
  else
    chezmoi init --debug --apply --verbose $CHEZMOI_USER
  fi
}

# os specific pre-requisites
if [ "$(uname)" == "Darwin" ]; then
  install_homebrew
fi

install_chezmoi

# in devcontainer/codespace
if [ -n "$REMOTE_CONTAINERS" ]; then
  prepare_devcontainer
fi

run_chezmoi
