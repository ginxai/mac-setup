#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

if [[ -d "/Applications/Visual Studio Code.app" ]] || command -v code &>/dev/null; then
  log_success "Visual Studio Code is already installed."
  exit 0
fi

brew install --cask visual-studio-code

log_success "Visual Studio Code installed successfully."
log_info "To install the 'code' CLI, open VS Code and run:"
log_info "  Shell Command: Install 'code' command in PATH"
log_info "(Open the Command Palette with Cmd+Shift+P and search for the above command)"
