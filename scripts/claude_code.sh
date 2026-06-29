#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/utils.sh"

# Check if claude is already installed
if command -v claude &>/dev/null; then
    log_success "claude is already installed: $(claude --version)"
    exit 0
fi

# Check for node/npm
if ! command -v node &>/dev/null || ! command -v npm &>/dev/null; then
    log_warn "Node.js and npm are required but not found. Please install Node.js first: https://nodejs.org"
    exit 1
fi

log_info "Installing Claude Code via npm..."
if ! npm install -g @anthropic-ai/claude-code; then
    log_error "Failed to install @anthropic-ai/claude-code"
    exit 1
fi

# Verify installation
if command -v claude &>/dev/null; then
    log_success "Claude Code installed successfully: $(claude --version)"
else
    log_error "Installation appeared to succeed but 'claude' command is not available. Check your PATH."
    exit 1
fi
