#!/bin/bash

# Setup Script for Nearbuy Local Development
# Run this to install dependencies if they are missing.

echo ">>> Starting Local Setup..."

# 1. Install Flutter if missing
# Install LOCALLY in ./tools/flutter
if [ ! -d "tools/flutter" ]; then
    echo ">>> Flutter not found. Downloading..."
    mkdir -p tools
    
    wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.2-stable.tar.xz
    
    echo ">>> Extracting Flutter..."
    tar -xf flutter_linux_3.22.2-stable.tar.xz -C tools/
    rm flutter_linux_3.22.2-stable.tar.xz
else
    echo ">>> Flutter already installed in tools/flutter."
fi

export PATH="$PATH:$(pwd)/tools/flutter/bin"
echo ">>> Flutter configured."
flutter --version

# 3. Precache Artifacts
echo ">>> Downloading Dart SDK and tools..."
flutter precache

echo ">>> Setup Complete!"
echo "Run 'source setup_env.sh' to activate this environment in your shell."
