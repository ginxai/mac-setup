#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/utils.sh
source "$SCRIPT_DIR/lib/utils.sh"

print_header "🍎  ginx macOS Setup"

# ── Homebrew ──────────────────────────────────────────────────────────────────
ensure_brew

# ── gum (interactive TUI) ─────────────────────────────────────────────────────
if ! is_cmd gum; then
  log_info "Installing gum for interactive UI..."
  brew install gum
fi

# ── Tool definitions: "script_id:Display Name" ────────────────────────────────
TOOLS=(
  "homebrew:Homebrew"
  "nodejs:Node.js"
  "claude_code:Claude Code"
  "ohmyzsh:Oh My Zsh"
  "iterm:iTerm2"
  "chrome:Google Chrome"
  "lark:Lark"
  "zalo:Zalo"
  "claude_desktop:Claude Desktop"
  "pnpm:pnpm"
  "docker:Docker"
  "vscode:VS Code"
  "rustdesk:RustDesk"
  "gh:GitHub CLI"
  "cloudflare:Cloudflare CLI"
  "pasty:Pasty"
)

# Build label arrays with STT prefix for display
LABELS=()
DISPLAY=()
for i in "${!TOOLS[@]}"; do
  label="${TOOLS[$i]#*:}"
  LABELS+=("$label")
  DISPLAY+=("$(printf '%2d. %s' "$((i + 1))" "$label")")
done

# Pre-select string for gum (display names, comma-separated)
PRESELECT="$(IFS=,; echo "${DISPLAY[*]}")"

# ── Interactive selection ──────────────────────────────────────────────────────
echo ""
SELECTED=$(gum choose \
  --no-limit \
  --selected="$PRESELECT" \
  --header "  Select tools to install  (Space = toggle · Enter = confirm)  " \
  --cursor.foreground="212" \
  --selected.foreground="212" \
  "${DISPLAY[@]}") || true

if [[ -z "$SELECTED" ]]; then
  log_warn "No tools selected. Exiting."
  exit 0
fi

TOTAL=$(echo "$SELECTED" | wc -l | tr -d ' ')
echo ""
log_info "Installing $TOTAL tool(s)..."

# ── Run install scripts ────────────────────────────────────────────────────────
FAILED=()
CURRENT=0
for i in "${!TOOLS[@]}"; do
  id="${TOOLS[$i]%%:*}"
  label="${TOOLS[$i]#*:}"
  display="${DISPLAY[$i]}"
  if echo "$SELECTED" | grep -qxF "$display"; then
    ((CURRENT++)) || true
    log_step "[$CURRENT/$TOTAL] $label"
    if bash "$SCRIPT_DIR/scripts/${id}.sh"; then
      :
    else
      FAILED+=("$label")
    fi
  fi
done

# ── Summary ───────────────────────────────────────────────────────────────────
echo ""
PASSED=$((TOTAL - ${#FAILED[@]}))
if [[ ${#FAILED[@]} -eq 0 ]]; then
  log_success "✅  Done! $PASSED/$TOTAL installed. Open a new terminal to apply shell changes."
else
  log_warn "$PASSED/$TOTAL installed. Failed: ${FAILED[*]}"
fi
