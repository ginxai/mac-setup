#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

if [[ -d "/Applications/Pasty.app" ]]; then
  log_success "Pasty is already installed."
  exit 0
fi

brew install --cask pasty

log_success "Pasty installed successfully. It will appear in the menu bar."
