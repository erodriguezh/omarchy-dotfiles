#!/bin/bash
set -euo pipefail

if [[ "$(uname -s)" != "Linux" ]]; then
  echo "These dotfiles only target Omarchy (Arch Linux)."
  exit 1
fi

# Very lightweight Omarchy detection
if [[ ! -d "$HOME/.local/share/omarchy" ]]; then
  echo "Omarchy markers not found in ~/.local/share/omarchy."
  echo "These dotfiles assume Omarchy's layout and may not behave correctly on plain Arch."
  exit 1
fi

echo "Setting up @erodr dotfiles for Omarchy."
