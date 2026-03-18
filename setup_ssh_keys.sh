#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== SSH Key Setup Script ===${NC}\n"

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

# Helper: check if a command exists
is_installed() {
    command -v "$1" &>/dev/null
}

# Ensure ~/.ssh exists with correct permissions
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# ── Key detection ─────────────────────────────────────────────────────────────
echo -e "${YELLOW}Checking for existing SSH keys...${NC}"

KEY_FOUND=false
KEY_FILE=""

for key in id_ed25519 id_rsa id_ecdsa id_dsa; do
    if [ -f "$HOME/.ssh/$key" ]; then
        KEY_FOUND=true
        KEY_FILE="$key"
        echo -e "${GREEN}Existing SSH key found: ~/.ssh/$key${NC}\n"
        break
    fi
done

# ── Key generation ────────────────────────────────────────────────────────────
if [ "$KEY_FOUND" = false ]; then
    echo -e "${YELLOW}No existing SSH key pair found. Generating a new ed25519 key...${NC}"
    echo -e "${YELLOW}You will be prompted to enter a passphrase. Please choose a strong one.${NC}\n"

    read -p "Enter a label/comment for the key (e.g. your email) [$(hostname)]: " KEY_COMMENT
    KEY_COMMENT="${KEY_COMMENT:-$(hostname)}"

    ssh-keygen -t ed25519 -C "$KEY_COMMENT" -f "$HOME/.ssh/id_ed25519"
    KEY_FILE="id_ed25519"
    echo -e "\n${GREEN}SSH key pair generated: ~/.ssh/id_ed25519${NC}\n"
fi

# Display public key
echo -e "${YELLOW}Your public key:${NC}"
cat "$HOME/.ssh/${KEY_FILE}.pub"
echo ""

# ── Upload to server ──────────────────────────────────────────────────────────
echo -e "${YELLOW}Would you like to upload your public key to an OpenSSH server?${NC}"
read -p "Upload key? (y/N): " UPLOAD_CHOICE

if [[ "$UPLOAD_CHOICE" =~ ^[Yy]$ ]]; then
    read -p "Remote username: " REMOTE_USER
    read -p "Remote host (IP or hostname): " REMOTE_HOST
    read -p "Remote port [22]: " REMOTE_PORT
    REMOTE_PORT="${REMOTE_PORT:-22}"

    echo -e "${YELLOW}Uploading public key to ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PORT}...${NC}"
    if ssh-copy-id -i "$HOME/.ssh/${KEY_FILE}.pub" -p "$REMOTE_PORT" "${REMOTE_USER}@${REMOTE_HOST}"; then
        echo -e "${GREEN}Public key uploaded successfully${NC}\n"
    else
        echo -e "${RED}Key upload failed. You can do it manually later with:${NC}"
        echo -e "${YELLOW}  ssh-copy-id -i ~/.ssh/${KEY_FILE}.pub -p $REMOTE_PORT ${REMOTE_USER}@${REMOTE_HOST}${NC}\n"
    fi
else
    echo -e "${YELLOW}Skipping key upload.${NC}\n"
fi

# ── Install keychain ──────────────────────────────────────────────────────────
# keychain starts ssh-agent once at first login and caches the agent socket,
# so subsequent terminal sessions (and reboots after re-login) reuse the same
# agent. You only ever enter your passphrase once per login session.
echo -e "${YELLOW}Installing keychain for persistent SSH agent management...${NC}"

if ! is_installed keychain; then
    if [ "$DISTRO_TYPE" == "arch" ]; then
        sudo pacman -S --noconfirm keychain
    elif [ "$DISTRO_TYPE" == "ubuntu" ]; then
        sudo apt install -y keychain
    fi
    echo -e "${GREEN}keychain installed successfully${NC}\n"
else
    echo -e "${GREEN}keychain already installed${NC}\n"
fi

# ── Configure shell rc files ──────────────────────────────────────────────────
KEYCHAIN_LINE="eval \"\$(keychain --eval --agents ssh --quiet \$HOME/.ssh/${KEY_FILE})\""

configure_shell_rc() {
    local rc_file="$1"

    if [ -f "$rc_file" ]; then
        if ! grep -q "keychain --eval" "$rc_file"; then
            {
                echo ""
                echo "# SSH agent via keychain — enter passphrase once per login session"
                echo "$KEYCHAIN_LINE"
            } >> "$rc_file"
            echo -e "${GREEN}keychain configured in $rc_file${NC}"
        else
            echo -e "${YELLOW}keychain already configured in $rc_file${NC}"
        fi
    else
        echo -e "${YELLOW}$rc_file not found. Skipping.${NC}"
    fi
}

echo -e "${YELLOW}Configuring keychain in shell rc files...${NC}"
configure_shell_rc "$HOME/.zshrc"
configure_shell_rc "$HOME/.bashrc"
echo ""

# ── Summary ───────────────────────────────────────────────────────────────────
echo -e "${GREEN}=== Setup Complete ===${NC}"
echo -e "${GREEN}✓ SSH key:  ~/.ssh/${KEY_FILE}${NC}"
echo -e "${GREEN}✓ keychain installed and configured${NC}\n"
echo -e "${YELLOW}How it works:${NC}"
echo -e "${YELLOW}  • The first terminal you open after login will prompt for your passphrase${NC}"
echo -e "${YELLOW}  • All subsequent terminals and SSH connections reuse the cached agent${NC}"
echo -e "${YELLOW}  • The agent is cleared on logout/reboot${NC}\n"
echo -e "${YELLOW}To apply changes in the current shell, run:${NC}"
echo -e "${YELLOW}  source ~/.zshrc    (zsh)${NC}"
echo -e "${YELLOW}  source ~/.bashrc   (bash)${NC}"
