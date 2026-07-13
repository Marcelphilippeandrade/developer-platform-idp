#!/bin/bash

# =====================================================
# Developer Platform Setup
# =====================================================

# -----------------------------------------------------
# Banner
# -----------------------------------------------------

echo "========================================="
echo " Developer Platform Setup"
echo "========================================="
echo ""

# -----------------------------------------------------
# Environment Detection
# -----------------------------------------------------

echo ""
echo "Detecting environment..."
echo ""

OS_NAME="$(uname -s)"
echo "Operating System : $OS_NAME"

ARCH="$(uname -m)"
echo "Architecture     : $ARCH"

source /etc/os-release
echo "Distribution     : $NAME"
echo "Version          : $VERSION_ID"

if grep -qi microsoft /proc/version; then
    WSL="Yes"
else
    WSL="No"
fi
echo "WSL              : $WSL"

# -----------------------------------------------------
# Environment Validation
# -----------------------------------------------------

echo ""
echo "Environment validation..."
echo ""

if [ "$OS_NAME" = "Linux" ]; then
    echo "✓ Linux"
else
    echo "✗ $OS_NAME"
    echo "ERROR: Unsupported operating system."
    echo ""
    echo "Supported operating systems:"
    echo "  - Windows 11"
    echo "  - WSL2"
    echo "  - Ubuntu 22.04 LTS"

    return 1 2>/dev/null || exit 1
fi

if [ "$NAME" = "Ubuntu" ]; then
    echo "✓ Ubuntu"
else
    echo "✗ $NAME"
    echo ""
    echo "ERROR: Unsupported Linux distribution."
    echo ""
    echo "Supported distribution:"
    echo "  Ubuntu"

    return 1 2>/dev/null || exit 1
fi

if [ "$VERSION_ID" = "22.04" ]; then
    echo "✓ Ubuntu 22.04"
else
    echo "✗ Ubuntu $VERSION_ID"
    echo ""
    echo "ERROR: Unsupported Ubuntu version."
    echo ""
    echo "Supported version:"
    echo "  Ubuntu 22.04 LTS"

    return 1 2>/dev/null || exit 1
fi

if [ "$WSL" = "Yes" ]; then
    echo "✓ WSL2"
else
    echo "✗ WSL"
    echo ""
    echo "ERROR: WSL2 not detected."
    echo ""
    echo "Developer Platform currently supports:"
    echo "  Windows 11 + WSL2"

    return 1 2>/dev/null || exit 1
fi

# -----------------------------------------------------
# System Prerequisites Validation
# -----------------------------------------------------
echo ""
echo "Checking prerequisites..."

if command -v git >/dev/null 2>&1; then
    echo "✓ Git"
else
    echo "✗ Git"
    echo ""
    echo "ERROR: Git is not installed."
    echo ""
    echo "Install it using:"
    echo "sudo apt install git"

    return 1 2>/dev/null || exit 1
fi

if command -v curl >/dev/null 2>&1; then
    echo "✓ curl"
else
    echo "✗ curl"
    echo ""
    echo "ERROR: curl is not installed."
    echo ""
    echo "Install it using:"
    echo "sudo apt install curl"
fi

if command -v wget >/dev/null 2>&1; then
    echo "✓ wget"
else
    echo "✗ wget"
    echo ""
    echo "ERROR: wget is not installed."
    echo ""
    echo "Install it using:"
    echo "sudo apt install wget"
fi

if command -v unzip >/dev/null 2>&1; then
    echo "✓ unzip"
else
    echo "✗ unzip"
    echo ""
    echo "ERROR: unzip is not installed."
    echo ""
    echo "Install it using:"
    echo "sudo apt install unzip"
fi

if command -v sudo >/dev/null 2>&1; then
    echo "✓ sudo"
else
    echo "✗ sudo"
    echo ""
    echo "ERROR: sudo is not installed."
    echo ""
    echo "Please install sudo or use a supported Ubuntu installation."
fi

# -----------------------------------------------------
# Developer Platform Components Validation
# -----------------------------------------------------

# -----------------------------------------------------
# Components Installation
# -----------------------------------------------------
echo ""
echo "Installing required components..."

# TODO

# -----------------------------------------------------
# Developer Platform Configuration
# -----------------------------------------------------
echo ""
echo "Configuring Developer Platform..."

# TODO

# -----------------------------------------------------
# Setup completed
# -----------------------------------------------------

echo ""
echo "Developer Platform setup completed successfully."