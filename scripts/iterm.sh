#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

if [ -d "/Applications/iTerm.app" ]; then
  log_success "iTerm.app is already installed."
  exit 0
fi

brew install --cask iterm2
log_success "iTerm2 installed successfully."
