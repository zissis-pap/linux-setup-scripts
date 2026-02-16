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
else
    echo -e "${RED}No supported package manager found (pacman or apt)${NC}"
    echo -e "${YELLOW}This script supports Arch-based (pacman) and Debian/Ubuntu-based (apt) systems only.${NC}"
    exit 1
fi

# Install Brave Browser
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

# Install Claude Code
echo -e "${YELLOW}Installing Claude Code...${NC}"
curl -fsSL https://claude.ai/install.sh | bash
echo -e "${GREEN}Claude Code installed successfully${NC}\n"

# Install Fresh Editor
echo -e "${YELLOW}Installing Fresh Editor...${NC}"
curl https://raw.githubusercontent.com/sinelaw/fresh/refs/heads/master/scripts/install.sh | sh
echo -e "${GREEN}Fresh Editor installed successfully${NC}\n"

# Install OpenCode
echo -e "${YELLOW}Installing OpenCode...${NC}"
curl -fsSL https://opencode.ai/install | bash
echo -e "${GREEN}OpenCode installed successfully${NC}\n"

# Install Podman
echo -e "${YELLOW}Installing Podman...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm podman
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    sudo apt update
    sudo apt install -y podman
fi

echo -e "${GREEN}Podman installed successfully${NC}\n"

# Install Distrobox
echo -e "${YELLOW}Installing Distrobox...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm distrobox
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
fi

echo -e "${GREEN}Distrobox installed successfully${NC}\n"

# Install time
echo -e "${YELLOW}Installing time...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm time
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    sudo apt install -y time
fi

echo -e "${GREEN}time installed successfully${NC}\n"

# Install tree
echo -e "${YELLOW}Installing tree...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm tree
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    sudo apt install -y tree
fi

echo -e "${GREEN}tree installed successfully${NC}\n"

# Install btop
echo -e "${YELLOW}Installing btop...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm btop
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    sudo apt install -y btop
fi

echo -e "${GREEN}btop installed successfully${NC}\n"

# Install amdgpu_top
echo -e "${YELLOW}Installing amdgpu_top...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm amdgpu_top
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    echo -e "${YELLOW}amdgpu_top is not available in official apt repositories. Skipping.${NC}"
    echo -e "${YELLOW}To install manually, download the .deb from: https://github.com/Umio-Yasuno/amdgpu_top/releases${NC}"
fi

echo -e "${GREEN}amdgpu_top step done${NC}\n"

# Install fastfetch
echo -e "${YELLOW}Installing fastfetch...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm fastfetch
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    if apt-cache show fastfetch &>/dev/null; then
        sudo apt install -y fastfetch
    else
        echo -e "${YELLOW}fastfetch not found in apt repositories. Skipping.${NC}"
    fi
fi

echo -e "${GREEN}fastfetch step done${NC}\n"

# Install mpv
echo -e "${YELLOW}Installing mpv...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm mpv
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    sudo apt install -y mpv
fi

echo -e "${GREEN}mpv installed successfully${NC}\n"

# Install yt-dlp
echo -e "${YELLOW}Installing yt-dlp...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm yt-dlp
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    if apt-cache show yt-dlp &>/dev/null; then
        sudo apt install -y yt-dlp
    else
        echo -e "${YELLOW}yt-dlp not found in apt repositories. Skipping.${NC}"
    fi
fi

echo -e "${GREEN}yt-dlp step done${NC}\n"

# Install mc (Midnight Commander)
echo -e "${YELLOW}Installing mc (Midnight Commander)...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm mc
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    sudo apt install -y mc
fi

echo -e "${GREEN}mc installed successfully${NC}\n"

# Install superfile
echo -e "${YELLOW}Installing superfile...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm superfile
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    echo -e "${YELLOW}superfile not available in official apt repositories. Skipping.${NC}"
fi

echo -e "${GREEN}superfile step done${NC}\n"

# Install navi
echo -e "${YELLOW}Installing navi...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm navi
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    echo -e "${YELLOW}navi not available in official apt repositories. Skipping.${NC}"
fi

echo -e "${GREEN}navi step done${NC}\n"

# Install dua-cli
echo -e "${YELLOW}Installing dua-cli...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm dua-cli
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    echo -e "${YELLOW}dua-cli not available in official apt repositories. Skipping.${NC}"
fi

echo -e "${GREEN}dua-cli step done${NC}\n"

# Install duf
echo -e "${YELLOW}Installing duf...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm duf
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    echo -e "${YELLOW}duf not available in official apt repositories. Skipping.${NC}"
fi

echo -e "${GREEN}duf step done${NC}\n"

# Install zoxide
echo -e "${YELLOW}Installing zoxide...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm zoxide
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    echo -e "${YELLOW}zoxide not available in official apt repositories. Skipping.${NC}"
fi

echo -e "${GREEN}zoxide step done${NC}\n"

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

# Final summary
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo -e "${GREEN}✓ Brave Browser installed${NC}"
echo -e "${GREEN}✓ Claude Code installed${NC}"
echo -e "${GREEN}✓ Fresh Editor installed${NC}"
echo -e "${GREEN}✓ OpenCode installed${NC}"
echo -e "${GREEN}✓ Podman installed${NC}"
echo -e "${GREEN}✓ Distrobox installed${NC}"
echo -e "${GREEN}✓ time installed${NC}"
echo -e "${GREEN}✓ tree installed${NC}"
echo -e "${GREEN}✓ btop installed${NC}"
if [ "$DISTRO_TYPE" == "arch" ]; then
    echo -e "${GREEN}✓ amdgpu_top installed${NC}"
else
    echo -e "${YELLOW}⚠ amdgpu_top skipped (not in apt repos - install manually from GitHub)${NC}"
fi
echo -e "${GREEN}✓ fastfetch installed (if available)${NC}"
echo -e "${GREEN}✓ mpv installed${NC}"
echo -e "${GREEN}✓ yt-dlp installed (if available)${NC}"
echo -e "${GREEN}✓ mc (Midnight Commander) installed${NC}"
echo -e "${GREEN}✓ superfile installed (if available)${NC}"
echo -e "${GREEN}✓ navi installed (if available)${NC}"
echo -e "${GREEN}✓ dua-cli installed (if available)${NC}"
echo -e "${GREEN}✓ duf installed (if available)${NC}"
echo -e "${GREEN}✓ zoxide installed (if available)${NC}\n"
echo -e "${YELLOW}Note: You may need to restart your terminal or run 'source ~/.bashrc' to use some tools${NC}"
