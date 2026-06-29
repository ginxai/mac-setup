#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/utils.sh
source "$SCRIPT_DIR/lib/utils.sh"

print_header "🍎  ginx macOS Setup"

# ── Homebrew (required before gum/everything else) ────────────────────────────
ensure_brew

# ── gum (interactive TUI) ─────────────────────────────────────────────────────
if ! is_cmd gum; then
  log_info "Installing gum for interactive UI..."
  brew install gum
fi

# ── Tool definitions: "script_id:Display Name" ────────────────────────────────
TOOLS=(
  "homebrew:Homebrew"
  "claude_code:Claude Code"
  "nodejs:Node.js"
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
  "pasty:Pasty"
)

LABELS=()
for t in "${TOOLS[@]}"; do LABELS+=("${t#*:}"); done

# ── Interactive selection (all pre-selected by default) ───────────────────────
echo ""
SELECTED=$(printf '%s\n' "${LABELS[@]}" | gum choose \
  --no-limit \
  --selected="$(IFS=,; echo "${LABELS[*]}")" \
  --header "  Select tools to install  (Space = toggle · Enter = confirm)" \
  --cursor.foreground="212" \
  --selected.foreground="212") || true

if [[ -z "$SELECTED" ]]; then
  log_warn "No tools selected. Exiting."
  exit 0
fi

echo ""
log_info "Installing selected tools..."

# ── Run install scripts for selected tools ────────────────────────────────────
FAILED=()
for tool in "${TOOLS[@]}"; do
  id="${tool%%:*}"
  label="${tool#*:}"
  if echo "$SELECTED" | grep -qxF "$label"; then
    log_step "$label"
    if bash "$SCRIPT_DIR/scripts/${id}.sh"; then
      :
    else
      FAILED+=("$label")
    fi
  fi
done

echo ""
if [[ ${#FAILED[@]} -eq 0 ]]; then
  log_success "✅  All done! Open a new terminal to apply any shell changes."
else
  log_warn "Completed with errors in: ${FAILED[*]}"
fi
