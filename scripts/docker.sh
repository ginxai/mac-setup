#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

if [[ -d "/Applications/Docker.app" ]]; then
  log_success "Docker is already installed."
  exit 0
fi

brew install --cask docker

log_success "Docker installed successfully."
log_info "Open Docker.app to complete setup."
open /Applications/Docker.app 2>/dev/null || true
