#!/bin/bash
export PATH="$PATH:$(pwd)/../tools/flutter/bin"
export ANDROID_HOME="$HOME/Android/Sdk"
echo "Environment configured. Flutter is available at: $(which flutter)"
flutter --version
