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

# Final summary
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo -e "${GREEN}✓ Brave Browser installed${NC}"
echo -e "${GREEN}✓ Claude Code installed${NC}"
echo -e "${GREEN}✓ Fresh Editor installed${NC}"
echo -e "${GREEN}✓ OpenCode installed${NC}"
echo -e "${GREEN}✓ Podman installed${NC}"
echo -e "${GREEN}✓ Distrobox installed${NC}\n"
echo -e "${YELLOW}Note: You may need to restart your terminal or run 'source ~/.bashrc' to use some tools${NC}"
