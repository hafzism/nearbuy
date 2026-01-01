#!/bin/bash
# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# Assuming 'tools' is inside the same directory as this script (nearbuy/nearbuy/tools) - based on install_dependencies.sh behavior inside "nearbuy"
export PATH="$PATH:$SCRIPT_DIR/tools/flutter/bin"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"
echo "Environment configured."
echo "Flutter: $SCRIPT_DIR/tools/flutter/bin"
echo "Android: $ANDROID_HOME"
echo "To verify, run: flutter doctor"

