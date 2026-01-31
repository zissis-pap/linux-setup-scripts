#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== ZeroTier and SSH Setup Script ===${NC}\n"

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

# Install ZeroTier
echo -e "${YELLOW}Installing ZeroTier...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm zerotier-one
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    curl -s https://install.zerotier.com | sudo bash
fi

echo -e "${GREEN}ZeroTier installed successfully${NC}\n"

# Enable and start ZeroTier service
echo -e "${YELLOW}Enabling and starting ZeroTier service...${NC}"
sudo systemctl enable zerotier-one
sudo systemctl start zerotier-one
echo -e "${GREEN}ZeroTier service enabled and started${NC}\n"

# Ask for network ID and join
echo -e "${YELLOW}Please enter your ZeroTier network ID:${NC}"
read -p "Network ID: " NETWORK_ID

if [ -z "$NETWORK_ID" ]; then
    echo -e "${RED}Network ID cannot be empty. Exiting.${NC}"
    exit 1
fi

echo -e "${YELLOW}Joining ZeroTier network...${NC}"
sudo zerotier-cli join "$NETWORK_ID"
echo -e "${GREEN}Joined ZeroTier network: $NETWORK_ID${NC}\n"

# Display ZeroTier status
echo -e "${YELLOW}ZeroTier status:${NC}"
sudo zerotier-cli info
echo ""

# Install SSH server
echo -e "${YELLOW}Installing SSH server...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo pacman -S --noconfirm openssh
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    sudo apt update
    sudo apt install -y openssh-server
fi

echo -e "${GREEN}SSH server installed successfully${NC}\n"

# Enable and start SSH service
echo -e "${YELLOW}Enabling and starting SSH service...${NC}"

if [ "$DISTRO_TYPE" == "arch" ]; then
    sudo systemctl enable sshd
    sudo systemctl start sshd
    SSH_SERVICE="sshd"
elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
    sudo systemctl enable ssh
    sudo systemctl start ssh
    SSH_SERVICE="ssh"
fi

echo -e "${GREEN}SSH service enabled and started${NC}\n"

# Display SSH status
echo -e "${YELLOW}SSH service status:${NC}"
sudo systemctl status $SSH_SERVICE --no-pager | head -n 5
echo ""

# Final summary
echo -e "${GREEN}=== Setup Complete ===${NC}"
echo -e "${GREEN}✓ ZeroTier installed and running${NC}"
echo -e "${GREEN}✓ Joined network: $NETWORK_ID${NC}"
echo -e "${GREEN}✓ SSH server installed and running${NC}\n"
echo -e "${YELLOW}Your ZeroTier IP address(es):${NC}"
sudo zerotier-cli listnetworks

echo -e "\n${YELLOW}Note: You may need to authorize this device in your ZeroTier network dashboard${NC}"
