#!/bin/bash
set -e

echo ">>> Setting up Android SDK..."

# Define Paths
export ANDROID_HOME="$HOME/Android/Sdk"
CMDLINE_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip"
TMP_ZIP="cmdline-tools.zip"

# Create Directory Structure
mkdir -p "$ANDROID_HOME/cmdline-tools"

# Download Command Line Tools if not present
if [ ! -d "$ANDROID_HOME/cmdline-tools/latest" ]; then
    echo ">>> Downloading Command Line Tools..."
    wget -q --show-progress "$CMDLINE_TOOLS_URL" -O "$TMP_ZIP"
    
    echo ">>> Extracting..."
    unzip -q "$TMP_ZIP" -d "$ANDROID_HOME/cmdline-tools"
    
    # Rename to 'latest' as required by sdkmanager
    mv "$ANDROID_HOME/cmdline-tools/cmdline-tools" "$ANDROID_HOME/cmdline-tools/latest"
    rm "$TMP_ZIP"
else
    echo ">>> Command Line Tools already installed."
fi

# Set PATH for this script execution
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"

# Install SDK Components
# We need: platform-tools, exact build-tools, and a platform (e.g., android-34)
echo ">>> Installing Platform Tools & Build Tools (Accepting Licenses)..."

# Pipe 'y' to accept licenses automatically
yes | sdkmanager --licenses > /dev/null

echo ">>> Installing Packages..."
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

echo ">>> Android SDK Setup Complete!"
echo "Location: $ANDROID_HOME"
