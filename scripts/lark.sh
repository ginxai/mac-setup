#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

if [[ -d "/Applications/Lark.app" ]]; then
  log_success "Lark is already installed."
  exit 0
fi

brew install --cask lark

log_success "Lark installed successfully."
