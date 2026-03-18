# 🚀 Setup Scripts Collection

[![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.linux.org)
[![Arch](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge)](https://archlinux.org)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

A collection of automated setup scripts for quickly configuring Linux systems (Arch and Debian/Ubuntu-based distributions).

## 📦 Config Files

This repository includes a submodule for [zissis-pap/config-files](https://github.com/zissis-pap/config-files) that provides curated configuration files for various tools.

**To initialize the submodule:**
```bash
git submodule update --init --recursive
```

The submodule is automatically detected by `setup_tools.sh` which prompts you to install the config files.

## 📋 Table of Contents

- [Overview](#-overview)
- [Scripts](#-scripts)
  - [Setup Tools](#-setup_toolssh)
  - [Setup AI Tools](#-setup_ai_toolssh)
  - [Setup ZeroTier & SSH](#-setup_zerotier_sshshsetup_zerotier_sshsh)
  - [Setup SSH Keys](#-setup_ssh_keyssh)
  - [Setup Zsh](#-setup_zshshsetup_zshsh)
- [Requirements](#-requirements)
- [Usage](#-usage)
- [Supported Distributions](#-supported-distributions)
- [Notes](#-notes)

## 🎯 Overview

These scripts automate the installation and configuration of essential tools and services for Linux development environments. Each script is designed to be idempotent and handles both Arch-based and Debian/Ubuntu-based distributions.

## 📦 Scripts

### 🔧 `setup_tools.sh`

Installs essential development tools and applications.

**What it installs:**
- [![Brave Browser](https://img.shields.io/badge/Brave_Browser-F3702A?style=for-the-badge&logo=brave&logoColor=white)](https://brave.com) - Privacy-focused web browser
- [![Claude Code](https://img.shields.io/badge/Claude_Code-242424?style=for-the-badge&logo=claude&logoColor=white)](https://claude.ai) - AI-powered coding assistant CLI
- [![Fresh Editor](https://img.shields.io/badge/Fresh_Editor-4F4F4F?style=for-the-badge&logo=visual-studio-code&logoColor=007ACC)](https://github.com/sinelaw/fresh) - Modern text editor
- [![OpenCode](https://img.shields.io/badge/OpenCode-121011?style=for-the-badge&logo=python&logoColor=white)](https://opencode.ai) - AI-powered code editor
- [![llama.cpp-vulkan](https://img.shields.io/badge/llama.cpp--vulkan-121011?style=for-the-badge&logo=python&logoColor=white)](https://github.com/ggml-org/llama.cpp) - GPU-accelerated LLM inference with Vulkan
- [![lemonade-server](https://img.shields.io/badge/lemonade--server-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white)](https://lemonade-server.ai) - Self-hosted AI assistant server
- [![fastflowlm](https://img.shields.io/badge/fastflowlm-FF5500?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://fastflowlm.com) - High-performance language model inference
- [![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com) - Container platform
- [![Podman](https://img.shields.io/badge/Podman-5A697B?style=for-the-badge&logo=podman&logoColor=white)](https://podman.io) - Daemonless container engine
- [![Distrobox](https://img.shields.io/badge/Distrobox-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://github.com/89luca89/distrobox) - Run any Linux distribution inside your terminal
- [![time](https://img.shields.io/badge/Time-4F4F4F?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/time/) - Measure program running time
- [![tree](https://img.shields.io/badge/tree-006400?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://mama.indstate.edu/users/ice/tree/) - Directory tree viewer
- [![btop](https://img.shields.io/badge/btop-212121?style=for-the-badge&logo=linux&logoColor=white)](https://github.com/arcticicestudio/btop) - Modern terminal resource monitor
- [![amdgpu_top](https://img.shields.io/badge/amdgpu_top-FF0000?style=for-the-badge&logo=amd&logoColor=white)](https://github.com/Umio-Yasuno/amdgpu_top) - AMD GPU monitoring tool
- [![fastfetch](https://img.shields.io/badge/fastfetch-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white)](https://github.com/fastfetch-cli/fastfetch) - System information tool
- [![mpv](https://img.shields.io/badge/mpv-1A1A1A?style=for-the-badge&logo=video-mp4&logoColor=white)](https://mpv.io) - Media player
- [![yt-dlp](https://img.shields.io/badge/yt--dlp-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://github.com/yt-dlp/yt-dlp) - YouTube video downloader
- [![mc](https://img.shields.io/badge/Midnight_Commander-343756?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.midnight-commander.com/) - File manager
- [![superfile](https://img.shields.io/badge/superfile-61DAFB?style=for-the-badge&logo=react&logoColor=white)](https://github.com/Mister-Boop/superfile) - Modern file manager (binary: `spf`)
- [![navi](https://img.shields.io/badge/navi-FF5500?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://github.com/denisidoro/navi) - Interactive command-line launcher
- [![dua-cli](https://img.shields.io/badge/dua--cli-FF5500?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://github.com/Byron/dua-cli) - Disk usage analyzer (binary: `dua`)
- [![duf](https://img.shields.io/badge/duf-FF5500?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://github.com/dexec/duf) - Disk usage/free utility
- [![zoxide](https://img.shields.io/badge/zoxide-FF5500?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://github.com/ajeetdsouza/zoxide) - Smart cd command
- [![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io) - Hyperextensible Vim-based text editor
- [![LazyVim](https://img.shields.io/badge/LazyVim-57A143?style=for-the-badge&logo=neovim&logoColor=white)](https://www.lazyvim.org) - Neovim setup powered by lazy.nvim
- [![kitty](https://img.shields.io/badge/kitty-1A1A1A?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://sw.kovidgoyal.net/kitty/) - Fast, feature-rich GPU-based terminal emulator
- [![tmux](https://img.shields.io/badge/tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)](https://github.com/tmux/tmux) - Terminal multiplexer

**Config files:**
The config files are stored in the `config-files/` submodule. When initialized, the script automatically detects and offers to install:
- [![kitty](https://img.shields.io/badge/kitty-1A1A1A?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://sw.kovidgoyal.net/kitty/) - Terminal emulator config (`~/.config/kitty/kitty.conf`)
- [![OpenCode](https://img.shields.io/badge/OpenCode-121011?style=for-the-badge&logo=python&logoColor=white)](https://opencode.ai) - Code editor config (`~/.config/opencode/opencode.json`)

**Usage:**
```bash
chmod +x setup_tools.sh
./setup_tools.sh
```

**Interactive prompts:**
- 🐳 Container runtime selection (Docker, Podman, Both, or Neither)
- ⚙️ Config file installation (kitty and opencode)

**Features:**
- Interactive container runtime selection (Docker, Podman, Both, or Neither)
- Config file installation from submodule or custom paths
- Automatically detects your package manager (pacman/apt)
- Installs paru (AUR helper) on Arch if not present
- Runs `apt update` once at the start on Debian/Ubuntu systems
- Checks if tools are already installed before installing (idempotent)
- Checks package availability before installing on apt — skips gracefully if a package is not in the repositories
- For apt-based systems, uses `dpkg` to check if packages are already installed

---

### 🔧 `setup_ai_tools.sh`

Installs AI tools and language model inference frameworks.

**What it installs:**
- [![llama.cpp-vulkan](https://img.shields.io/badge/llama.cpp--vulkan-121011?style=for-the-badge&logo=python&logoColor=white)](https://github.com/ggml-org/llama.cpp) - GPU-accelerated LLM inference with Vulkan support
- [![lemonade-server](https://img.shields.io/badge/lemonade--server-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white)](https://lemonade-server.ai) - Self-hosted AI assistant server
- [![fastflowlm](https://img.shields.io/badge/fastflowlm-FF5500?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://fastflowlm.com) - High-performance language model inference

**Usage:**
```bash
chmod +x setup_ai_tools.sh
./setup_ai_tools.sh
```

**Features:**
- Uses `paru` (AUR helper) on Arch-based systems for llama.cpp-vulkan and lemonade-server
- Uses `pacman` on Arch-based systems for fastflowlm
- Falls back to building from source on Debian/Ubuntu-based systems
- Automatically detects your package manager (pacman/apt)
- Checks if tools are already installed before installing (idempotent)

**Supported Distributions:**
- Arch-based: Uses `paru` and `pacman`
- Debian/Ubuntu-based: Builds llama.cpp-vulkan and lemonade-server from source (fastflowlm requires Arch)

---

**Submodule setup:**
```bash
git submodule update --init --recursive
```

---

### 🌐 `setup_zerotier_ssh.sh`

Sets up ZeroTier VPN and SSH server for secure remote access.

**What it does:**
- Installs and configures **[ZeroTier One](https://www.zerotier.com)**
- Installs and enables **SSH server** ([OpenSSH](https://www.openssh.com))
- Joins your specified ZeroTier network
- Automatically starts and enables services on boot

**Usage:**
```bash
chmod +x setup_zerotier_ssh.sh
./setup_zerotier_ssh.sh
```

**Interactive prompts:**
- 🆔 ZeroTier Network ID (you'll need this from your ZeroTier account)

**Features:**
- Correctly handles SSH service names (`sshd` for Arch, `ssh` for Debian/Ubuntu)
- Displays ZeroTier IP addresses after setup
- Shows service status for verification

**Post-installation:**
- 📝 Remember to authorize your device in the ZeroTier network dashboard
- 🔑 Your ZeroTier IP will be displayed - use it for SSH connections

---

### 🔑 `setup_ssh_keys.sh`

Generates an SSH key pair with a passphrase and configures the agent so the passphrase is entered only once per login session.

**What it does:**
- Detects existing SSH keys (`id_ed25519`, `id_rsa`, `id_ecdsa`, `id_dsa`) — skips generation if one is found
- Generates a new **ed25519** key pair and prompts for a passphrase
- Optionally uploads the public key to a remote OpenSSH server via `ssh-copy-id`
- Installs **[keychain](https://www.funtoo.org/Keychain)** and configures it in `~/.zshrc` and `~/.bashrc`

**Usage:**
```bash
chmod +x setup_ssh_keys.sh
./setup_ssh_keys.sh
```

**Interactive prompts:**
- 🏷️ Key label/comment (e.g. your email or hostname)
- 🔐 Passphrase (entered directly via `ssh-keygen`)
- 📤 Whether to upload the public key to a remote server (user/host/port)

**Features:**
- Uses ed25519 (modern, secure key type)
- `~/.ssh` is created with correct `700` permissions if it doesn't exist
- keychain starts `ssh-agent` once at first login; all subsequent terminals reuse the cached agent — no repeated passphrase prompts
- Gracefully handles `ssh-copy-id` failures (prints the manual command instead of aborting)
- Idempotent: won't add duplicate keychain lines to rc files

**How the passphrase caching works:**
The following line is appended to your shell rc files:
```bash
eval "$(keychain --eval --agents ssh --quiet $HOME/.ssh/id_ed25519)"
```
The first terminal opened after login prompts for the passphrase once. All subsequent terminals and SSH connections reuse the running agent. The agent is cleared on logout or reboot.

---

### 🐚 `setup_zsh.sh`

Transforms your terminal with zsh, oh-my-zsh, and beautiful themes.

**What it installs:**
- **[Zsh](https://www.zsh.org)** - Powerful shell
- **[Oh-My-Zsh](https://ohmyz.sh)** - Zsh configuration framework
- **[Powerlevel10k](https://github.com/romkatv/powerlevel10k)** - Fast and customizable theme
- **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)** - Fish-like autosuggestions
- **[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)** - Syntax highlighting for commands
- **[Nerd Fonts](https://www.nerdfonts.com)** - Icon-packed fonts (Hack, Meslo, Monaspace, Source Code Pro, Space Mono)

**Usage:**
```bash
chmod +x setup_zsh.sh
./setup_zsh.sh
```

**Interactive prompts:**
- 📁 Installation directory for oh-my-zsh (default: `~/.oh-my-zsh`)
- 🖋️ Install recommended Nerd Fonts (default: `y`)

**Features:**
- Automatically backs up existing `.zshrc` before modifications
- Skips already installed components
- Option to install 5 popular Nerd Fonts (can be skipped)
- Updates font cache (if fonts installed)
- **Automatically sets zsh as your default shell**

**Post-installation:**
- ⚠️ **Important**: Restart your computer after running this script for the shell change to take effect properly
- Powerlevel10k configuration wizard will start automatically
- If fonts were installed, select one of the installed Nerd Fonts in your terminal settings for best experience

## ⚙️ Requirements

- Linux system (Arch-based or Debian/Ubuntu-based)
- sudo privileges
- Internet connection
- Package manager: `pacman` or `apt`

## 🎮 Usage

### Quick Start

1. **Clone or download** the scripts to your system
2. **Initialize the config-files submodule:**
   ```bash
   git submodule update --init --recursive
   ```

3. **Make them executable:**
   ```bash
   chmod +x setup_*.sh
   ```

4. **✅ First: Run the Zsh setup script** (recommended to run first for best experience):
   ```bash
   ./setup_zsh.sh
   ```

4. **🔄 Restart your computer** for shell changes to take effect properly

5. **🚀 Then run the remaining scripts**:
    ```bash
    ./setup_tools.sh        # Install development tools (includes config file installation)
    ./setup_ai_tools.sh     # Install AI tools (llama.cpp-vulkan, lemonade-server, fastflowlm)
    ./setup_zerotier_ssh.sh # Setup ZeroTier and SSH server
    ./setup_ssh_keys.sh     # Generate SSH key pair and configure passphrase caching
    ```

### Run All Scripts

To set up a complete development environment:

```bash
chmod +x setup_*.sh

# 1. Run Zsh setup first
./setup_zsh.sh

# 2. Restart your computer

# 3. Run remaining scripts
./setup_tools.sh        # Includes interactive config file installation
./setup_ai_tools.sh     # Install AI tools (llama.cpp-vulkan, lemonade-server, fastflowlm)
./setup_zerotier_ssh.sh # Setup ZeroTier and SSH server
./setup_ssh_keys.sh     # Generate SSH key pair and configure passphrase caching
```

## 🐧 Supported Distributions

### ✅ Arch-based
- Arch Linux
- CachyOS
- EndeavourOS
- Manjaro
- Garuda Linux
- Any distribution using `pacman`

### ✅ Debian/Ubuntu-based
- Ubuntu
- Debian
- Linux Mint
- Pop!_OS
- Elementary OS
- Any distribution using `apt`

## 📝 Notes

- All scripts use `set -e` to exit on errors for safety
- Scripts include color-coded output for better readability
- Backup files are created automatically where applicable
- ⚠️ **For best results, run `setup_zsh.sh` first, then restart your computer** before running other scripts
- Scripts are designed to be run multiple times safely (idempotent)
- **Config files**: The `config-files/` submodule contains curated configs for kitty and opencode. Initialize with `git submodule update --init --recursive`. `setup_tools.sh` prompts to install these configs or use custom paths
- **AI tools**: `setup_ai_tools.sh` requires Arch-based system for optimal installation (uses `paru` and `pacman`). On Debian/Ubuntu, builds from source (fastflowlm requires Arch)
- **Note for zsh configuration**: Changes to `.zshrc` are applied only once, but require `source ~/.zshrc` or a new terminal to take effect

## 🎨 Color Guide

Throughout script execution, you'll see color-coded messages:
- 🟢 **Green** - Success messages and info
- 🟡 **Yellow** - Warnings and prompts
- 🔴 **Red** - Error messages

## 🤝 Contributing

Feel free to modify these scripts to suit your needs. They're designed to be readable and easy to customize.

## 👤 Author

**Zissis Papadopoulos**

## 📄 License

MIT - These scripts are provided as-is for personal use
