#!/usr/bin/env bash

# Terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

print_header() { echo -e "\n${BOLD}${CYAN}$1${NC}\n"; }
log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[ OK ]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error()   { echo -e "${RED}[ERR ]${NC} $1" >&2; }
log_step()    { echo -e "\n${BOLD}${GREEN}▶ $1${NC}"; }

ensure_brew() {
  if ! command -v brew &>/dev/null; then
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to PATH — Apple Silicon (/opt/homebrew) or Intel (/usr/local)
    if [[ -f /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f /usr/local/bin/brew ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  else
    log_success "Homebrew already installed ($(brew --version | head -1))"
  fi
}

is_cmd() { command -v "$1" &>/dev/null; }

is_cask() { brew list --cask "$1" &>/dev/null 2>&1; }

# Get installed version of a cask
_cask_version() { brew list --cask --versions "$1" 2>/dev/null | awk '{print $2}'; }

# Get installed version of a formula
_formula_version() { brew list --versions "$1" 2>/dev/null | awk '{print $2}'; }

install_cask() {
  local cask="$1"
  local name="${2:-$1}"
  if is_cask "$cask"; then
    local ver; ver=$(_cask_version "$cask")
    if brew outdated --cask --quiet 2>/dev/null | grep -qx "$cask"; then
      log_info "$name v$ver → update available, upgrading..."
      brew upgrade --cask "$cask" && log_success "$name updated" || log_warn "Could not update $name"
    else
      log_success "$name already installed (v$ver, up to date)"
    fi
  else
    log_info "Installing $name..."
    brew install --cask "$cask" && log_success "$name installed" || log_error "Failed to install $name"
  fi
}

install_formula() {
  local formula="$1"
  local name="${2:-$1}"
  if brew list "$formula" &>/dev/null 2>&1; then
    local ver; ver=$(_formula_version "$formula")
    if brew outdated --formula --quiet 2>/dev/null | grep -qx "$formula"; then
      log_info "$name v$ver → update available, upgrading..."
      brew upgrade "$formula" && log_success "$name updated" || log_warn "Could not update $name"
    else
      log_success "$name already installed (v$ver, up to date)"
    fi
  else
    log_info "Installing $name..."
    brew install "$formula" && log_success "$name installed" || log_error "Failed to install $name"
  fi
}
