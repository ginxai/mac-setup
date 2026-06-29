# ginx-setup-macos

Interactive CLI to set up a macOS development environment with one command.

![Platform](https://img.shields.io/badge/platform-macOS%2012%2B-lightgrey)
![License](https://img.shields.io/badge/license-MIT-blue)

## Features

- Interactive checkbox UI — select only the tools you want to install
- All tools are pre-selected by default for a full setup experience
- Powered by [gum](https://github.com/charmbracelet/gum) for a clean terminal interface
- Installs tools via Homebrew, Homebrew Cask, npm, or curl depending on the tool

## Requirements

- macOS 12 or later
- Internet connection
- Homebrew — automatically installed if not already present

## Quick Start

```bash
git clone git@gitlab.com:ginx-internal/infra/ginx-setup-macos.git
cd ginx-setup-macos
chmod +x install.sh
./install.sh
```

## Tools Included

| # | Tool | Description | Install Method |
|---|------|-------------|----------------|
| 1 | Claude Code | Anthropic's AI CLI | npm |
| 2 | Node.js | JavaScript runtime | Homebrew |
| 3 | Oh My Zsh | Zsh framework | curl |
| 4 | iTerm2 | Terminal emulator | Homebrew Cask |
| 5 | Google Chrome | Web browser | Homebrew Cask |
| 6 | Lark | Team collaboration | Homebrew Cask |
| 7 | Zalo | Messaging app | Homebrew Cask |
| 8 | Claude Desktop | AI desktop app | Homebrew Cask |
| 9 | pnpm | Fast package manager | Homebrew |
| 10 | Docker | Container platform | Homebrew Cask |
| 11 | VS Code | Code editor | Homebrew Cask |
| 12 | RustDesk | Remote desktop | Homebrew Cask |
| 13 | Pasty | Clipboard manager | Homebrew Cask |

## How It Works

When you run `./install.sh`, the script:

1. Checks for Homebrew and installs it automatically if missing.
2. Installs `gum` to power the interactive terminal UI.
3. Presents a checkbox list of all available tools — all pre-selected by default.
4. You navigate with arrow keys, toggle selections with Space, and confirm with Enter.
5. Only the tools you selected are installed, in order, using the appropriate method for each.

This makes it easy to get a full dev environment in one go, or hand-pick just the tools you need.

## License

MIT
