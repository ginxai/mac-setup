#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

if [[ -d "/Applications/RustDesk.app" ]]; then
  log_success "RustDesk is already installed."
  exit 0
fi

brew install --cask rustdesk

log_success "RustDesk installed successfully."
