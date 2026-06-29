#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

install_formula "gh" "GitHub CLI"

# Prompt auth if not logged in
if is_cmd gh && ! gh auth status &>/dev/null 2>&1; then
  log_info "Run 'gh auth login' to authenticate with GitHub"
fi
