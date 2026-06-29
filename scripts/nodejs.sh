#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/utils.sh
source "$SCRIPT_DIR/../lib/utils.sh"

if command -v node &>/dev/null; then
  NODE_VERSION="$(node --version)"
  log_info "node is already installed: $NODE_VERSION"
  exit 0
fi

log_info "Installing Node.js via Homebrew..."
brew install node

NODE_VERSION="$(node --version)"
NPM_VERSION="$(npm --version)"

log_success "Node.js installed successfully — node $NODE_VERSION, npm $NPM_VERSION"
