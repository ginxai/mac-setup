# ginx-setup-macos

Cài đặt toàn bộ môi trường dev macOS bằng một lệnh duy nhất — có giao diện checkbox để chọn công cụ, mặc định chọn tất cả.

![Platform](https://img.shields.io/badge/platform-macOS%2012%2B-lightgrey)
![Arch](https://img.shields.io/badge/arch-Apple%20Silicon%20%7C%20Intel-blue)
![License](https://img.shields.io/badge/license-MIT-green)

---

## Chạy nhanh (không cần cài gì trước)

```bash
/bin/bash -c "$(curl -fsSL https://YOUR_DOMAIN/setup.sh)"
```

Script tự động xử lý mọi thứ từ đầu: Xcode CLT → Homebrew → clone repo → chạy installer.

---

## Cách hoạt động

```
curl setup.sh
     │
     ▼
┌─────────────────────────────────────┐
│  1. Kiểm tra macOS                  │
│  2. Cài Xcode Command Line Tools    │  ← cần cho git/curl
│  3. Cài Homebrew                    │  ← package manager
│  4. Clone repo về ~/.ginx-setup-macos│
│  5. Chạy install.sh                 │
└─────────────────────────────────────┘
     │
     ▼
┌─────────────────────────────────────┐
│  Giao diện checkbox (gum)           │
│                                     │
│  ◉ Homebrew                         │
│  ◉ Claude Code                      │
│  ◉ Node.js                          │
│  ◉ Oh My Zsh                        │
│  ◉ iTerm2                           │
│  ◉ ...                              │
│                                     │
│  Space = toggle  ·  Enter = cài     │
└─────────────────────────────────────┘
     │
     ▼
  Cài từng tool đã chọn theo thứ tự
```

Nếu chạy lại lần 2: script tự `git pull` để lấy version mới nhất, rồi tiếp tục.

---

## Yêu cầu

| | |
|---|---|
| **Hệ điều hành** | macOS 12 Monterey trở lên |
| **Kiến trúc** | Apple Silicon (M1/M2/M3/M4) và Intel |
| **Kết nối** | Internet |
| **Cài trước** | Không cần gì — script tự lo hết |

---

## Công cụ được hỗ trợ

| # | Công cụ | Mô tả | Cài qua |
|---|---------|-------|---------|
| 1 | **Homebrew** | Package manager cho macOS | curl |
| 2 | **Claude Code** | AI coding CLI của Anthropic | npm |
| 3 | **Node.js** | JavaScript runtime + npm | Homebrew |
| 4 | **Oh My Zsh** | Framework quản lý cấu hình zsh | curl |
| 5 | **iTerm2** | Terminal thay thế Terminal.app | Homebrew Cask |
| 6 | **Google Chrome** | Trình duyệt web | Homebrew Cask |
| 7 | **Lark** | Công cụ cộng tác nhóm | Homebrew Cask |
| 8 | **Zalo** | Nhắn tin (fallback: App Store) | Homebrew Cask |
| 9 | **Claude Desktop** | App desktop của Anthropic | Homebrew Cask |
| 10 | **pnpm** | Package manager nhanh cho Node | Homebrew |
| 11 | **Docker** | Nền tảng container | Homebrew Cask |
| 12 | **VS Code** | Trình soạn thảo code | Homebrew Cask |
| 13 | **RustDesk** | Remote desktop | Homebrew Cask |
| 14 | **GitHub CLI** | `gh auth login` để kết nối GitHub | Homebrew |
| 15 | **Cloudflare CLI** | Wrangler — deploy Workers, Pages | npm / Homebrew |
| 16 | **Pasty** | Clipboard manager | Mac App Store (`mas`) |

---

## Cài thủ công (nếu đã có git)

```bash
git clone https://gitlab.com/ginx-internal/infra/ginx-setup-macos.git
cd ginx-setup-macos
./install.sh
```

---

## Cấu trúc project

```
ginx-setup-macos/
├── setup.sh          # Bootstrap — chạy qua curl, tự cài Homebrew + clone repo
├── install.sh        # Installer chính — giao diện checkbox chọn tool
├── lib/
│   └── utils.sh      # Màu sắc, logging, helper functions
└── scripts/
    ├── homebrew.sh
    ├── claude_code.sh
    ├── nodejs.sh
    └── ...           # 1 file/tool
```

---

## Tùy chỉnh thư mục cài

Mặc định repo clone về `~/.ginx-setup-macos`. Đổi bằng biến môi trường:

```bash
GINX_SETUP_DIR=~/my-setup /bin/bash -c "$(curl -fsSL https://YOUR_DOMAIN/setup.sh)"
```

---

## License

MIT
