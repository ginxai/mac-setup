#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

if [ -d "/Applications/Zalo.app" ]; then
    log_success "Zalo is already installed."
    exit 0
fi

if brew install --cask zalo 2>/dev/null; then
    log_success "Zalo installed successfully via Homebrew."
else
    log_info "Zalo is not available via Homebrew. Opening the App Store for manual installation..."
    open "https://apps.apple.com/us/app/zalo/id1163299778"
    log_info "Please install Zalo manually from the App Store."
fi
