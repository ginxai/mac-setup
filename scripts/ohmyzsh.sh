#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

if [ -d "$HOME/.oh-my-zsh" ]; then
  log_success "Oh My Zsh already installed"
  exit 0
fi

# RUNZSH=no avoids spawning a new shell mid-install
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

log_success "Oh My Zsh installed successfully."
log_info "To set zsh as your default shell, run: chsh -s \$(which zsh)"
