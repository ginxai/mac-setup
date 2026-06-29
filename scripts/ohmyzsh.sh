#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/utils.sh"

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
ZSHRC="$HOME/.zshrc"

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  log_info "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  log_success "Oh My Zsh installed"
else
  log_success "Oh My Zsh already installed"
fi

# ── Powerlevel10k ─────────────────────────────────────────────────────────────
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
if [[ ! -d "$P10K_DIR" ]]; then
  log_info "Installing Powerlevel10k..."
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

# ── MesloLGS Nerd Font (required for p10k icons) ─────────────────────────────
if ! brew list --cask font-meslo-lg-nerd-font &>/dev/null 2>&1; then
  log_info "Installing MesloLGS Nerd Font..."
  brew install --cask font-meslo-lg-nerd-font
  log_success "MesloLGS Nerd Font installed"
else
  log_success "MesloLGS Nerd Font already installed"
fi

# ── Apply p10k lean config (no wizard) ────────────────────────────────────────
P10K_CONFIG="$HOME/.p10k.zsh"
P10K_LEAN="$P10K_DIR/config/p10k-lean.zsh"
if [[ ! -f "$P10K_CONFIG" ]]; then
  if [[ -f "$P10K_LEAN" ]]; then
    cp "$P10K_LEAN" "$P10K_CONFIG"
    log_success "Powerlevel10k: lean style applied"
  fi
else
  log_success "p10k config already exists"
fi

# ── Configure .zshrc ──────────────────────────────────────────────────────────
# Theme
if grep -q 'ZSH_THEME=' "$ZSHRC" 2>/dev/null; then
  sed -i '' 's|ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$ZSHRC"
else
  echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC"
fi

# Plugins
if grep -q '^plugins=' "$ZSHRC" 2>/dev/null; then
  sed -i '' 's|^plugins=.*|plugins=(git zsh-autosuggestions zsh-syntax-highlighting)|' "$ZSHRC"
else
  echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> "$ZSHRC"
fi

# Source p10k config at end of .zshrc
if ! grep -q 'p10k.zsh' "$ZSHRC" 2>/dev/null; then
  printf '\n# Powerlevel10k\n[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh\n' >> "$ZSHRC"
fi

# ── Auto-set iTerm2 font ──────────────────────────────────────────────────────
ITERM_PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
if [[ -f "$ITERM_PLIST" ]]; then
  # Quit iTerm2 first so plist changes aren't overwritten
  osascript -e 'tell application "iTerm2" to quit' 2>/dev/null || true
  sleep 1
  /usr/libexec/PlistBuddy \
    -c "Set 'New Bookmarks':0:'Normal Font' 'MesloLGSNFRegular 14'" \
    -c "Set 'New Bookmarks':0:'Non Ascii Font' 'MesloLGSNFRegular 14'" \
    -c "Set 'New Bookmarks':0:'Use Non-ASCII Font' true" \
    "$ITERM_PLIST" 2>/dev/null \
    && log_success "iTerm2 font set to MesloLGS NF 14" \
    || log_info "Set iTerm2 font manually: Preferences → Profiles → Text → MesloLGS NF"
fi

log_success "Shell ready: Powerlevel10k (lean) + autosuggestions + syntax highlighting"
log_info "Open a new terminal to see the new prompt ✨"
