#!/usr/bin/env bash
#
# ginx macOS Setup — remote bootstrap
#
# Run with:
#   /bin/bash -c "$(curl -fsSL https://YOUR_DOMAIN/setup.sh)"
#
set -euo pipefail

REPO_URL="https://gitlab.com/ginx-internal/infra/ginx-setup-macos.git"
INSTALL_DIR="${GINX_SETUP_DIR:-$HOME/.ginx-setup-macos}"

# ── Colors (no utils.sh yet) ──────────────────────────────────────────────────
BOLD='\033[1m'; CYAN='\033[0;36m'; GREEN='\033[0;32m'
BLUE='\033[0;34m'; NC='\033[0m'
info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[ OK ]${NC} $1"; }
header()  { echo -e "\n${BOLD}${CYAN}$1${NC}\n"; }

header "🍎  ginx macOS Setup"

# ── macOS check ───────────────────────────────────────────────────────────────
if [[ "$(uname)" != "Darwin" ]]; then
  echo "This script is for macOS only." >&2
  exit 1
fi

# ── Xcode Command Line Tools (provides git + curl) ────────────────────────────
if ! xcode-select -p &>/dev/null 2>&1; then
  info "Installing Xcode Command Line Tools (required for git)..."
  xcode-select --install
  info "Waiting for Xcode CLT installation to complete..."
  until xcode-select -p &>/dev/null 2>&1; do sleep 5; done
  success "Xcode Command Line Tools installed"
fi

# ── Homebrew ──────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
  success "Homebrew installed"
else
  success "Homebrew already installed"
fi

# ── Clone or update repo ──────────────────────────────────────────────────────
if [[ -d "$INSTALL_DIR/.git" ]]; then
  info "Updating ginx-setup-macos..."
  git -C "$INSTALL_DIR" pull --ff-only --quiet
  success "Updated to latest version"
else
  info "Cloning ginx-setup-macos to $INSTALL_DIR..."
  git clone --quiet "$REPO_URL" "$INSTALL_DIR"
  success "Cloned successfully"
fi

# ── Run installer ─────────────────────────────────────────────────────────────
bash "$INSTALL_DIR/install.sh"
