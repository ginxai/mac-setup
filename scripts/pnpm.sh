#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

if command -v pnpm &>/dev/null; then
  version="$(pnpm --version)"
  log_info "pnpm is already installed (version $version)"
  exit 0
fi

log_info "Installing pnpm via Homebrew..."
brew install pnpm

version="$(pnpm --version)"
log_success "pnpm installed successfully (version $version)"
