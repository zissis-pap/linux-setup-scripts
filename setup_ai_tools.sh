#!/usr/bin/env bash

set -e

echo "🚀 Setting up AI tools..."

if command -v pacman &> /dev/null; then
    echo "📦 Detected pacman (Arch-based)"
    
    if ! command -v paru &> /dev/null; then
        echo "📥 Installing paru (AUR helper)..."
        sudo pacman -Syu --noconfirm paru
    fi
    
    echo " installing llama.cpp-vulkan..."
    paru -S --noconfirm llama.cpp-vulkan
    
    echo "📦 Installing lemonade-server..."
    paru -S --noconfirm lemonade-server
    
    echo "📦 Installing fastflowlm..."
    sudo pacman -S --noconfirm fastflowlm
    
elif command -v apt &> /dev/null; then
    echo "📦 Detected apt (Debian/Ubuntu-based)"
    
    echo "❌ fastflowlm requires pacman (Arch-based) and is not available on apt-based systems"
    echo "ℹ️  Skipping fastflowlm installation"
    
    echo "📦 Updating package lists..."
    sudo apt update
    
    echo "📦 Installing dependencies..."
    sudo apt install -y build-essential git cmake
    
    echo "📦 Installing llama.cpp with Vulkan support..."
    git clone https://github.com/ggml-org/llama.cpp
    cd llama.cpp
    make clean
    make LLAMA_VULKAN=1
    sudo make install
    cd ..
    rm -rf llama.cpp
    
    echo "📦 Installing lemonade-server..."
    git clone https://github.com/lemonade-server/lemonade-server
    cd lemonade-server
    cargo build --release
    sudo cp target/release/lemonade-server /usr/local/bin/
    cd ..
    rm -rf lemonade-server
    
else
    echo "❌ No supported package manager found (pacman or apt)"
    exit 1
fi

echo "✅ AI tools setup complete!"
echo "ℹ️  llama.cpp-vulkan: https://github.com/ggml-org/llama.cpp"
echo "ℹ️  lemonade-server: https://lemonade-server.ai"
echo "ℹ️  fastflowlm: https://fastflowlm.com"
