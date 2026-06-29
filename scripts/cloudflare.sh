#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

# Check current version if already installed
if is_cmd wrangler; then
  local_ver=$(wrangler --version 2>/dev/null | head -1 || echo "?")
  latest_ver=$(npm view wrangler version 2>/dev/null || echo "?")
  if [[ "$local_ver" == *"$latest_ver"* ]]; then
    log_success "Cloudflare Wrangler already installed ($local_ver, up to date)"
  else
    log_info "Updating Wrangler ($local_ver → $latest_ver)..."
    npm install -g wrangler && log_success "Wrangler updated to $latest_ver"
  fi
  exit 0
fi

# Install via npm if available, else brew
if is_cmd npm; then
  log_info "Installing Cloudflare Wrangler via npm..."
  npm install -g --allow-scripts=esbuild,workerd,sharp wrangler
  log_success "Cloudflare Wrangler installed ($(wrangler --version 2>/dev/null | head -1))"
else
  log_info "Installing Cloudflare Wrangler via Homebrew..."
  install_formula "cloudflare-wrangler2" "Cloudflare Wrangler"
fi

log_info "Run 'wrangler login' to authenticate with Cloudflare"
