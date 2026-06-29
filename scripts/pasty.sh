#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

PASTY_APP_ID="1544620654"

# Check if already installed
if mas list 2>/dev/null | grep -q "^$PASTY_APP_ID"; then
  log_success "Pasty already installed (App Store)"
  exit 0
fi

# Ensure mas (Mac App Store CLI) is available
if ! is_cmd mas; then
  log_info "Installing mas (Mac App Store CLI)..."
  brew install mas
fi

log_info "Installing Pasty from App Store..."
mas install "$PASTY_APP_ID"
log_success "Pasty installed — check your menu bar"
