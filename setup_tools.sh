#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Tools Installation Script ===${NC}\n"

# Detect package manager
echo -e "${YELLOW}Detecting package manager...${NC}"

if command -v pacman &> /dev/null; then
    DISTRO_TYPE="arch"
    echo -e "${GREEN}pacman detected - Arch-based system${NC}\n"
elif command -v apt &> /dev/null; then
    DISTRO_TYPE="ubuntu"
    echo -e "${GREEN}apt detected - Debian/Ubuntu-based system${NC}\n"
    sudo apt update
else
    echo -e "${RED}No supported package manager found (pacman or apt)${NC}"
    echo -e "${YELLOW}This script supports Arch-based (pacman) and Debian/Ubuntu-based (apt) systems only.${NC}"
    exit 1
fi

# Helper function to check if a command is already installed
is_installed() {
    command -v "$1" &>/dev/null
}

# Helper function for apt installations with package availability check
apt_install() {
    local package="$1"
    if ! dpkg -l "$package" &>/dev/null 2>&1; then
        if apt-cache show "$package" &>/dev/null 2>&1; then
            sudo apt install -y "$package"
        else
            echo -e "${YELLOW}$package not found in apt repositories. Skipping.${NC}"
        fi
    else
        echo -e "${GREEN}$package already installed${NC}"
    fi
}

# Install Brave Browser
if ! is_installed brave; then
    echo -e "${YELLOW}Installing Brave Browser...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        # Check if paru is installed
        if ! command -v paru &> /dev/null; then
            echo -e "${YELLOW}paru not found. Installing paru first...${NC}"
            sudo pacman -S --needed --noconfirm base-devel git
            cd /tmp
            git clone https://aur.archlinux.org/paru.git
            cd paru
            makepkg -si --noconfirm
            cd ~
        fi
        paru -S --noconfirm brave-bin
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        curl -fsS https://dl.brave.com/install.sh | sh
    fi

    echo -e "${GREEN}Brave Browser installed successfully${NC}\n"
else
    echo -e "${GREEN}Brave Browser already installed${NC}\n"
fi

# Install Claude Code
if ! is_installed claude; then
    echo -e "${YELLOW}Installing Claude Code...${NC}"
    curl -fsSL https://claude.ai/install.sh | bash
    echo -e "${GREEN}Claude Code installed successfully${NC}\n"
else
    echo -e "${GREEN}Claude Code already installed${NC}\n"
fi

# Install Fresh Editor
if ! is_installed fresh; then
    echo -e "${YELLOW}Installing Fresh Editor...${NC}"
    curl https://raw.githubusercontent.com/sinelaw/fresh/refs/heads/master/scripts/install.sh | sh
    echo -e "${GREEN}Fresh Editor installed successfully${NC}\n"
else
    echo -e "${GREEN}Fresh Editor already installed${NC}\n"
fi

# Install OpenCode
if ! is_installed opencode; then
    echo -e "${YELLOW}Installing OpenCode...${NC}"
    curl -fsSL https://opencode.ai/install | bash
    echo -e "${GREEN}OpenCode installed successfully${NC}\n"
else
    echo -e "${GREEN}OpenCode already installed${NC}\n"
fi

# Install Podman
if ! is_installed podman; then
    echo -e "${YELLOW}Installing Podman...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm podman
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install podman
    fi

    echo -e "${GREEN}Podman step done${NC}\n"
else
    echo -e "${GREEN}Podman already installed${NC}\n"
fi

# Install Distrobox
if ! is_installed distrobox; then
    echo -e "${YELLOW}Installing Distrobox...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm distrobox
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
    fi

    echo -e "${GREEN}Distrobox installed successfully${NC}\n"
else
    echo -e "${GREEN}Distrobox already installed${NC}\n"
fi

# Install time
if ! is_installed time; then
    echo -e "${YELLOW}Installing time...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm time
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install time
    fi

    echo -e "${GREEN}time step done${NC}\n"
else
    echo -e "${GREEN}time already installed${NC}\n"
fi

# Install tree
if ! is_installed tree; then
    echo -e "${YELLOW}Installing tree...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm tree
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install tree
    fi

    echo -e "${GREEN}tree step done${NC}\n"
else
    echo -e "${GREEN}tree already installed${NC}\n"
fi

# Install btop
if ! is_installed btop; then
    echo -e "${YELLOW}Installing btop...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm btop
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install btop
    fi

    echo -e "${GREEN}btop step done${NC}\n"
else
    echo -e "${GREEN}btop already installed${NC}\n"
fi

# Install amdgpu_top
if ! is_installed amdgpu_top; then
    echo -e "${YELLOW}Installing amdgpu_top...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm amdgpu_top
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install amdgpu-top
    fi

    echo -e "${GREEN}amdgpu_top step done${NC}\n"
else
    echo -e "${GREEN}amdgpu_top already installed${NC}\n"
fi

# Install fastfetch
if ! is_installed fastfetch; then
    echo -e "${YELLOW}Installing fastfetch...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm fastfetch
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install fastfetch
    fi

    echo -e "${GREEN}fastfetch step done${NC}\n"
else
    echo -e "${GREEN}fastfetch already installed${NC}\n"
fi

# Install mpv
if ! is_installed mpv; then
    echo -e "${YELLOW}Installing mpv...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm mpv
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install mpv
    fi

    echo -e "${GREEN}mpv step done${NC}\n"
else
    echo -e "${GREEN}mpv already installed${NC}\n"
fi

# Install yt-dlp
if ! is_installed yt-dlp; then
    echo -e "${YELLOW}Installing yt-dlp...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm yt-dlp
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install yt-dlp
    fi

    echo -e "${GREEN}yt-dlp step done${NC}\n"
else
    echo -e "${GREEN}yt-dlp already installed${NC}\n"
fi

# Install mc (Midnight Commander)
if ! is_installed mc; then
    echo -e "${YELLOW}Installing mc (Midnight Commander)...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm mc
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install mc
    fi

    echo -e "${GREEN}mc step done${NC}\n"
else
    echo -e "${GREEN}mc already installed${NC}\n"
fi

# Install superfile
if ! is_installed spf; then
    echo -e "${YELLOW}Installing superfile...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm superfile
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install superfile
    fi

    echo -e "${GREEN}superfile step done${NC}\n"
else
    echo -e "${GREEN}superfile (spf) already installed${NC}\n"
fi

# Install navi
if ! is_installed navi; then
    echo -e "${YELLOW}Installing navi...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm navi
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install navi
    fi

    echo -e "${GREEN}navi step done${NC}\n"
else
    echo -e "${GREEN}navi already installed${NC}\n"
fi

# Install dua-cli
if ! is_installed dua; then
    echo -e "${YELLOW}Installing dua-cli...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm dua-cli
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install dua-cli
    fi

    echo -e "${GREEN}dua-cli step done${NC}\n"
else
    echo -e "${GREEN}dua-cli (dua) already installed${NC}\n"
fi

# Install duf
if ! is_installed duf; then
    echo -e "${YELLOW}Installing duf...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm duf
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install duf
    fi

    echo -e "${GREEN}duf step done${NC}\n"
else
    echo -e "${GREEN}duf already installed${NC}\n"
fi

# Install zoxide
if ! is_installed zoxide; then
    echo -e "${YELLOW}Installing zoxide...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm zoxide
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install zoxide
    fi

    echo -e "${GREEN}zoxide step done${NC}\n"
else
    echo -e "${GREEN}zoxide already installed${NC}\n"
fi

# Add zoxide init to .zshrc
echo -e "${YELLOW}Adding zoxide init to ~/.zshrc...${NC}"
if [ -f ~/.zshrc ]; then
    if ! grep -q "eval \"\$(zoxide init zsh)\"" ~/.zshrc; then
        echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
        echo -e "${GREEN}zoxide init added to ~/.zshrc${NC}"
    else
        echo -e "${YELLOW}zoxide init already exists in ~/.zshrc${NC}"
    fi
else
    echo -e "${YELLOW}~/.zshrc not found. Skipping.${NC}"
fi
echo -e "${GREEN}zoxide setup complete${NC}\n"

# Install Neovim
if ! is_installed nvim; then
    echo -e "${YELLOW}Installing Neovim...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm neovim
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install neovim
    fi

    echo -e "${GREEN}Neovim step done${NC}\n"
else
    echo -e "${GREEN}Neovim already installed${NC}\n"
fi

# Install LazyVim
if [ ! -d ~/.config/nvim ]; then
    echo -e "${YELLOW}Installing LazyVim...${NC}"
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
    echo -e "${GREEN}LazyVim installed successfully${NC}\n"
else
    echo -e "${GREEN}LazyVim already installed${NC}\n"
fi

# Install kitty
if ! is_installed kitty; then
    echo -e "${YELLOW}Installing kitty...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm kitty
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install kitty
    fi

    echo -e "${GREEN}kitty step done${NC}\n"
else
    echo -e "${GREEN}kitty already installed${NC}\n"
fi

# Install tmux
if ! is_installed tmux; then
    echo -e "${YELLOW}Installing tmux...${NC}"

    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm tmux
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        apt_install tmux
    fi

    echo -e "${GREEN}tmux step done${NC}\n"
else
    echo -e "${GREEN}tmux already installed${NC}\n"
fi

# Final summary
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo -e "${GREEN}✓ Brave Browser installed${NC}"
echo -e "${GREEN}✓ Claude Code installed${NC}"
echo -e "${GREEN}✓ Fresh Editor installed${NC}"
echo -e "${GREEN}✓ OpenCode installed${NC}"
echo -e "${GREEN}✓ Podman installed (if available)${NC}"
echo -e "${GREEN}✓ Distrobox installed${NC}"
echo -e "${GREEN}✓ time installed (if available)${NC}"
echo -e "${GREEN}✓ tree installed (if available)${NC}"
echo -e "${GREEN}✓ btop installed (if available)${NC}"
echo -e "${GREEN}✓ amdgpu_top installed (if available)${NC}"
echo -e "${GREEN}✓ fastfetch installed (if available)${NC}"
echo -e "${GREEN}✓ mpv installed (if available)${NC}"
echo -e "${GREEN}✓ yt-dlp installed (if available)${NC}"
echo -e "${GREEN}✓ mc (Midnight Commander) installed (if available)${NC}"
echo -e "${GREEN}✓ superfile (spf) installed (if available)${NC}"
echo -e "${GREEN}✓ navi installed (if available)${NC}"
echo -e "${GREEN}✓ dua-cli (dua) installed (if available)${NC}"
echo -e "${GREEN}✓ duf installed (if available)${NC}"
echo -e "${GREEN}✓ zoxide installed (if available)${NC}"
echo -e "${GREEN}✓ Neovim installed (if available)${NC}"
echo -e "${GREEN}✓ LazyVim installed${NC}"
echo -e "${GREEN}✓ kitty installed (if available)${NC}"
echo -e "${GREEN}✓ tmux installed (if available)${NC}\n"
echo -e "${YELLOW}Note: You may need to restart your terminal or run 'source ~/.bashrc' to use some tools${NC}"
