#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  log_info "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  log_success "Oh My Zsh installed"
else
  log_success "Oh My Zsh already installed"
fi

# ── Powerlevel10k theme ───────────────────────────────────────────────────────
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
if [[ ! -d "$P10K_DIR" ]]; then
  log_info "Installing Powerlevel10k theme..."
  git clone --depth=1 --quiet https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
  log_success "Powerlevel10k installed"
else
  log_success "Powerlevel10k already installed"
fi

# ── Plugins ───────────────────────────────────────────────────────────────────
PLUGINS_DIR="$ZSH_CUSTOM/plugins"
mkdir -p "$PLUGINS_DIR"

if [[ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]]; then
  log_info "Installing zsh-autosuggestions..."
  git clone --depth=1 --quiet https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
  log_success "zsh-autosuggestions installed"
else
  log_success "zsh-autosuggestions already installed"
fi

if [[ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]]; then
  log_info "Installing zsh-syntax-highlighting..."
  git clone --depth=1 --quiet https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGINS_DIR/zsh-syntax-highlighting"
  log_success "zsh-syntax-highlighting installed"
else
  log_success "zsh-syntax-highlighting already installed"
fi

# ── Configure .zshrc ──────────────────────────────────────────────────────────
ZSHRC="$HOME/.zshrc"

# Set theme to powerlevel10k
if grep -q 'ZSH_THEME=' "$ZSHRC" 2>/dev/null; then
  sed -i '' 's|ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$ZSHRC"
else
  echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC"
fi

# Set plugins
if grep -q '^plugins=' "$ZSHRC" 2>/dev/null; then
  sed -i '' 's|^plugins=.*|plugins=(git zsh-autosuggestions zsh-syntax-highlighting)|' "$ZSHRC"
else
  echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> "$ZSHRC"
fi

log_success "Oh My Zsh configured: Powerlevel10k + autosuggestions + syntax highlighting"
log_info "Open a new terminal then run: p10k configure"
