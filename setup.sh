#!/bin/bash
set -e

if [ "$(uname -s)" != "Linux" ]; then
  echo "These dotfiles only target Omarchy"
  exit 1
fi

echo "Setting up @erodr dotfiles."
