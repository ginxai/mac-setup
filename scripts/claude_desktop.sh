#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

if [[ -d "/Applications/Claude.app" ]]; then
  log_success "Claude.app is already installed."
  exit 0
fi

brew install --cask claude

log_success "Claude Desktop installed successfully."
