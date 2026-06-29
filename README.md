<div align="center">

# 🍎 mac-setup

**Set up a new Mac in minutes, not hours.**

One command. Interactive checklist. Everything you need.

[![macOS](https://img.shields.io/badge/macOS-12%2B-black?logo=apple\&logoColor=white)](https://www.apple.com/macos/)
[![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-✓-black?logo=apple\&logoColor=white)](https://support.apple.com/en-us/HT211814)
[![Intel](https://img.shields.io/badge/Intel-✓-blue)](https://support.apple.com/en-us/HT211814)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Stars](https://img.shields.io/github/stars/ginx/mac-setup?style=social)](https://github.com/ginx/mac-setup/stargazers)

<br/>

```bash
/bin/bash -c "$(curl -fsSL https://YOUR_DOMAIN/setup.sh)"
```

<br/>

![demo](https://YOUR_DOMAIN/demo.gif)

</div>

---

## ✨ Features

- **One command** — paste and go, even on a brand-new Mac with nothing installed
- **Interactive UI** — beautiful checkbox selector powered by [gum](https://github.com/charmbracelet/gum)
- **All pre-selected by default** — confirm with Enter to install everything, or deselect what you don't need
- **Smart re-runs** — skips already-installed tools, upgrades outdated ones automatically
- **Apple Silicon & Intel** — works on both architectures out of the box
- **No sudo abuse** — only escalates when Homebrew genuinely needs it

---

## 🚀 Quick Start

Paste this into your terminal — nothing needs to be installed first:

```bash
/bin/bash -c "$(curl -fsSL https://YOUR_DOMAIN/setup.sh)"
```

The script will:

1. Install **Xcode Command Line Tools** (if missing)
2. Install **Homebrew** (if missing)
3. Clone this repo to `~/.mac-setup`
4. Launch the **interactive installer**

> On subsequent runs, it pulls the latest version of this repo before launching.

---

## 🛠 Tools

| # | Tool | What it does | Install via |
|---|------|-------------|-------------|
| 1 | 🍺 **Homebrew** | Package manager for macOS | `curl` |
| 2 | ⬡ **Node.js** | JavaScript runtime + npm | Homebrew |
| 3 | 🤖 **Claude Code** | AI coding CLI by Anthropic | npm |
| 4 | 💤 **Oh My Zsh** | Zsh configuration framework | `curl` |
| 5 | 🖥 **iTerm2** | Better terminal for macOS | Homebrew Cask |
| 6 | 🌐 **Google Chrome** | Web browser | Homebrew Cask |
| 7 | 🐦 **Lark** | Team collaboration suite | Homebrew Cask |
| 8 | 💬 **Zalo** | Messaging app | Homebrew Cask |
| 9 | 🧠 **Claude Desktop** | Anthropic's desktop AI app | Homebrew Cask |
| 10 | 📦 **pnpm** | Fast, disk-efficient package manager | Homebrew |
| 11 | 🐳 **Docker** | Container platform | Homebrew Cask |
| 12 | 💻 **VS Code** | Code editor | Homebrew Cask |
| 13 | 🖥 **RustDesk** | Open-source remote desktop | Homebrew Cask |
| 14 | 🐙 **GitHub CLI** | `gh` — manage GitHub from terminal | Homebrew |
| 15 | ☁️ **Cloudflare CLI** | Wrangler — deploy Workers & Pages | npm |
| 16 | 📋 **Pasty** | Clipboard manager | Mac App Store |

---

## 📦 What it looks like

```
🍎  mac-setup

[ OK ] Homebrew already installed (Homebrew 4.x)
[INFO] Installing gum for interactive UI...

  Select tools to install  (Space = toggle · Enter = confirm)

>  ✓  1. Homebrew
   ✓  2. Node.js
   ✓  3. Claude Code
   ✓  4. Oh My Zsh
   ✓  5. iTerm2
   ✓  6. Google Chrome
      ...

[INFO] Installing 16 tool(s)...

▶ [1/16] Homebrew
[ OK ] Homebrew already installed (v4.3.x, up to date)

▶ [2/16] Node.js
[INFO] Installing Node.js via Homebrew...
[ OK ] Node.js installed — node v22.x, npm v10.x

...

✅  Done! 16/16 installed. Open a new terminal to apply shell changes.
```

---

## ⚙️ How it works

```
curl setup.sh
     │
     ▼
┌──────────────────────────────────────┐
│  1. Check macOS                      │
│  2. Install Xcode CLT  (if missing)  │
│  3. Install Homebrew   (if missing)  │
│  4. Clone / pull repo                │
│  5. Launch install.sh                │
└──────────────────────────────────────┘
     │
     ▼
   gum checkbox UI  →  run scripts/  →  summary
```

Each tool lives in its own `scripts/<tool>.sh` — easy to read, fork, and extend.

---

## 🗂 Project structure

```
mac-setup/
├── setup.sh          # Remote bootstrap — works via curl
├── install.sh        # Interactive installer (gum UI)
├── lib/
│   └── utils.sh      # Shared helpers: colors, logging, brew utils
└── scripts/
    ├── homebrew.sh
    ├── nodejs.sh
    ├── claude_code.sh
    └── ...           # One file per tool
```

---

## 🔧 Customize

**Change install directory:**
```bash
GINX_SETUP_DIR=~/my-setup /bin/bash -c "$(curl -fsSL https://YOUR_DOMAIN/setup.sh)"
```

**Run locally (if you've already cloned):**
```bash
git clone https://github.com/ginx/mac-setup.git
cd mac-setup
./install.sh
```

**Add your own tool:**

1. Create `scripts/mytool.sh`
2. Add `"mytool:My Tool"` to the `TOOLS` array in `install.sh`
3. Done — it shows up in the checkbox list automatically

---

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=ginx/mac-setup&type=Date)](https://star-history.com/#ginx/mac-setup&Date)

---

## 🤝 Contributing

PRs welcome! To add a new tool:

1. Fork the repo
2. Create `scripts/yourtool.sh` following the pattern of existing scripts
3. Add it to `TOOLS` in `install.sh`
4. Open a PR

---

## 📄 License

MIT © [ginx](https://github.com/ginx)
