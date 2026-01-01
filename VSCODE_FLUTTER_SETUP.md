# VSCode & Flutter USB Debugging Guide

## 1. Enable Developer Mode on Android Phone
1.  Go to **Settings** > **About Phone**.
2.  Tap **Build Number** 7 times until it says "You are a developer".
3.  Go back to **Settings** > **System** > **Developer Options**.
4.  Enable **USB Debugging**.

## 2. Connect via USB
1.  Plug your Android phone into your PC via USB.
2.  On your phone, a prompt will appear: "Allow USB Debugging?". Check "Always allow" and tap **Allow**.

## 3. Verify Connection in Terminal
Run `flutter devices` in your terminal. You should see your phone listed:
```
Hafeez's Phone (mobile) • RZ8T12345 • android-arm64 • Android 13 (API 33)
```

## 4. Run in VSCode
1.  Open the `mobile` folder in VSCode.
2.  Press **F5** (or Run > Start Debugging).
3.  VSCode will build the APK and install it on your connected phone.
4.  **Hot Reload**: When you save a file (`Ctrl+S`), the app updates instantly on the phone without rebuilding!

## Troubleshooting
*   **"No devices found"**: Ensure USB cable is data-capable (not just charging). Try a different port.
*   **"Insufficient permissions"**: Run `adb kill-server` then `adb start-server` (requires Android SDK platform-tools installed).
