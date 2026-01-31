#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect package manager
echo_info "Detecting package manager..."
if command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -S --noconfirm"
    echo_info "Detected: pacman"
elif command -v apt &> /dev/null; then
    PKG_MANAGER="apt"
    INSTALL_CMD="sudo apt install -y"
    echo_info "Detected: apt"
else
    echo_error "Neither pacman nor apt found. Exiting."
    exit 1
fi

# Update package manager
echo_info "Updating package manager..."
if [ "$PKG_MANAGER" = "apt" ]; then
    sudo apt update
fi

# Install required packages
echo_info "Installing wget, curl, git, and zsh..."
$INSTALL_CMD wget curl git zsh

# Ask for ZSH installation directory
echo ""
read -p "Enter the path for oh-my-zsh installation (default: ~/.oh-my-zsh): " ZSH_DIR
ZSH_DIR=${ZSH_DIR:-~/.oh-my-zsh}
ZSH_DIR=$(eval echo "$ZSH_DIR") # Expand ~ to home directory

# Check if oh-my-zsh directory already exists
if [ -d "$ZSH_DIR" ]; then
    echo_warn "Oh-My-Zsh directory already exists at $ZSH_DIR. Skipping installation."
else
    echo_info "Installing oh-my-zsh to $ZSH_DIR..."
    ZSH="$ZSH_DIR" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set ZSH_CUSTOM directory
ZSH_CUSTOM="${ZSH_DIR}/custom"

# Install zsh-syntax-highlighting
echo_info "Installing zsh-syntax-highlighting plugin..."
if [ -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
    echo_warn "zsh-syntax-highlighting already exists. Skipping."
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
fi

# Install zsh-autosuggestions
echo_info "Installing zsh-autosuggestions plugin..."
if [ -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
    echo_warn "zsh-autosuggestions already exists. Skipping."
else
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
fi

# Install powerlevel10k theme
echo_info "Installing powerlevel10k theme..."
if [ -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then
    echo_warn "powerlevel10k already exists. Skipping."
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"
fi

# Update .zshrc file
ZSHRC="$HOME/.zshrc"
echo_info "Updating $ZSHRC..."

if [ -f "$ZSHRC" ]; then
    # Backup .zshrc
    cp "$ZSHRC" "${ZSHRC}.backup.$(date +%Y%m%d_%H%M%S)"
    echo_info "Backup created: ${ZSHRC}.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Update plugins line
    if grep -q "^plugins=(" "$ZSHRC"; then
        # Check if plugins already added
        if grep -q "zsh-autosuggestions" "$ZSHRC" && grep -q "zsh-syntax-highlighting" "$ZSHRC"; then
            echo_warn "Plugins already configured in .zshrc"
        else
            sed -i 's/^plugins=(\(.*\))/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
            echo_info "Updated plugins in .zshrc"
        fi
    else
        echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> "$ZSHRC"
        echo_info "Added plugins to .zshrc"
    fi
    
    # Update theme
    if grep -q 'ZSH_THEME="powerlevel10k/powerlevel10k"' "$ZSHRC"; then
        echo_warn "Theme already set to powerlevel10k"
    else
        sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC"
        echo_info "Updated theme to powerlevel10k"
    fi
else
    echo_error ".zshrc not found at $HOME/.zshrc"
fi

# Download and install Nerd Fonts
echo_info "Installing Nerd Fonts..."

# Create fonts directory if it doesn't exist
FONTS_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONTS_DIR"

# Create temporary directory for downloads
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Array of font URLs
FONTS=(
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Monaspace.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SpaceMono.zip"
)

# Download and extract fonts
for FONT_URL in "${FONTS[@]}"; do
    FONT_NAME=$(basename "$FONT_URL" .zip)
    echo_info "Downloading $FONT_NAME..."
    wget -q "$FONT_URL" -O "${FONT_NAME}.zip"
    
    echo_info "Extracting $FONT_NAME..."
    unzip -q "${FONT_NAME}.zip" -d "$FONT_NAME"
    
    echo_info "Installing $FONT_NAME fonts..."
    find "$FONT_NAME" -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp {} "$FONTS_DIR" \;
done

# Clean up
echo_info "Cleaning up temporary files..."
cd - > /dev/null
rm -rf "$TEMP_DIR"

# Update font cache
echo_info "Updating font cache..."
fc-cache -f "$FONTS_DIR"

# Set zsh as default shell
echo_info "Setting zsh as default shell..."
chsh -s $(which zsh)
echo_info "Default shell changed to zsh"

echo ""
echo_info "========================================="
echo_info "Installation complete!"
echo_info "========================================="
echo ""
echo_info "To apply changes:"
echo_info "1. Log out and log back in (or restart your terminal)"
echo_info "2. Powerlevel10k configuration wizard will start automatically"
echo_info "3. Make sure to select one of the installed Nerd Fonts in your terminal settings"
echo ""
echo_info "Installed Nerd Fonts:"
echo_info "  - Hack Nerd Font"
echo_info "  - Meslo Nerd Font"
echo_info "  - Monaspace Nerd Font"
echo_info "  - Source Code Pro Nerd Font"
echo_info "  - Space Mono Nerd Font"
echo ""