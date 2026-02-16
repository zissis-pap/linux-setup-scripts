# 🚀 Setup Scripts Collection

[![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.linux.org)
[![Arch](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge)](https://archlinux.org)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

A collection of automated setup scripts for quickly configuring Linux systems (Arch and Debian/Ubuntu-based distributions).

## 📋 Table of Contents

- [Overview](#-overview)
- [Scripts](#-scripts)
  - [Setup Tools](#-setup_toolssh)
  - [Setup ZeroTier & SSH](#-setup_zerotier_sshshsetup_zerotier_sshsh)
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

**Usage:**
```bash
chmod +x setup_tools.sh
./setup_tools.sh
```

**Features:**
- Automatically detects your package manager (pacman/apt)
- Installs paru (AUR helper) on Arch if not present
- Handles all dependencies automatically

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

**Features:**
- Automatically backs up existing `.zshrc` before modifications
- Skips already installed components
- Installs 5 popular Nerd Fonts automatically
- Updates font cache
- **Automatically sets zsh as your default shell**

**Post-installation:**
- ⚠️ **Important**: Restart your computer after running this script for the shell change to take effect properly
- Powerlevel10k configuration wizard will start automatically
- Select one of the installed Nerd Fonts in your terminal settings for best experience

## ⚙️ Requirements

- Linux system (Arch-based or Debian/Ubuntu-based)
- sudo privileges
- Internet connection
- Package manager: `pacman` or `apt`

## 🎮 Usage

### Quick Start

1. **Clone or download** the scripts to your system
2. **Make them executable:**
   ```bash
   chmod +x setup_*.sh
   ```

3. **✅ First: Run the Zsh setup script** (recommended to run first for best experience):
   ```bash
   ./setup_zsh.sh
   ```

4. **🔄 Restart your computer** for shell changes to take effect properly

5. **🚀 Then run the remaining scripts**:
   ```bash
   ./setup_tools.sh        # Install development tools
   ./setup_zerotier_ssh.sh # Setup ZeroTier and SSH
   ```

### Run All Scripts

To set up a complete development environment:

```bash
chmod +x setup_*.sh

# 1. Run Zsh setup first
./setup_zsh.sh

# 2. Restart your computer

# 3. Run remaining scripts
./setup_tools.sh
./setup_zerotier_ssh.sh
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

## 🎨 Color Guide

Throughout script execution, you'll see color-coded messages:
- 🟢 **Green** - Success messages and info
- 🟡 **Yellow** - Warnings and prompts
- 🔴 **Red** - Error messages

## 🤝 Contributing

Feel free to modify these scripts to suit your needs. They're designed to be readable and easy to customize.

## 📄 License

MIT - These scripts are provided as-is for personal use
