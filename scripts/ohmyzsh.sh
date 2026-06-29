#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

if [ -d "$HOME/.oh-my-zsh" ]; then
  log "Oh My Zsh already installed"
  exit 0
fi

# Note: uses RUNZSH=no to avoid spawning a new shell during install
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

log "Oh My Zsh installed successfully."
log "To set zsh as your default shell, run: chsh -s \$(which zsh)"
