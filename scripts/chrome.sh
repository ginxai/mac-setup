#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

if [[ -d "/Applications/Google Chrome.app" ]]; then
  log_success "Google Chrome is already installed."
  exit 0
fi

brew install --cask google-chrome

log_success "Google Chrome installed successfully."
