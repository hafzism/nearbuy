#!/bin/bash

# Setup Script for Nearbuy Local Development
# Run this to install dependencies if they are missing.

echo ">>> Starting Local Setup..."

# 1. Install Flutter if missing
# Line 10: Point to parent tools folder
if [ ! -d "../tools/flutter" ]; then
    echo ">>> Flutter not found. Downloading..."
    mkdir -p ../tools
    
    # ... (curl stuff) ...
    echo ">>> Extracting Flutter..."
    # Line 22: Extract into parent tools folder
    tar -xf flutter.tar.xz -C ../tools/
    rm flutter.tar.xz
else
    echo ">>> Flutter already installed in tools/flutter."
fi
# Line 30: Update path to point one level up
export PATH="$PATH:$(pwd)/../tools/flutter/bin"
echo ">>> Flutter configured."
flutter --version

# 3. Precache Artifacts
echo ">>> Downloading Dart SDK and tools..."
flutter precache

echo ">>> Setup Complete!"
echo "Run 'source setup_env.sh' to activate this environment in your shell."
