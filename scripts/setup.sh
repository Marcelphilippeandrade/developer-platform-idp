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
echo ""

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

    return 1 2>/dev/null || exit 1
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

    return 1 2>/dev/null || exit 1
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

    return 1 2>/dev/null || exit 1
fi

if command -v sudo >/dev/null 2>&1; then
    echo "✓ sudo"
else
    echo "✗ sudo"
    echo ""
    echo "ERROR: sudo is not installed."
    echo ""
    echo "Please install sudo or use a supported Ubuntu installation."

    return 1 2>/dev/null || exit 1
fi

# -----------------------------------------------------
# Developer Platform Components
# -----------------------------------------------------
echo ""
echo "Checking Developer Platform components..."
echo ""

if command -v java >/dev/null 2>&1; then
    JAVA_VERSION="$(
        java -version 2>&1 |
        head -n 1 |
        sed -E 's/.*"([^"]+)".*/\1/')"

    echo "✓ Java"
    echo "Version: $JAVA_VERSION"

else

    echo "✗ Java"
    echo ""

    echo "Java is required by the Developer Platform."
    echo ""

    read -rp "Install OpenJDK 21 now? [y/N]: " INSTALL_JAVA

    if [[ "$INSTALL_JAVA" =~ ^[Yy]$ ]]; then
        echo ""
        echo "Installing OpenJDK 21..."
        echo ""
        echo "Updating package list..."

        sudo apt update
        
        echo ""
        echo "Package list updated successfully."

        echo ""
        echo "Installing OpenJDK 21..."

        sudo apt install -y openjdk-21-jdk

        if command -v java >/dev/null 2>&1; then
            JAVA_VERSION="$(
                java -version 2>&1 |
                head -n 1 |
                sed -E 's/.*"([^"]+)".*/\1/')"

            echo ""
            echo "✓ Java"
            echo "Version: $JAVA_VERSION"
        else
            echo ""
            echo "ERROR: Java installation failed."

            return 1 2>/dev/null || exit 1

    fi
        else
            echo ""
            echo "Java installation skipped."

            return 1 2>/dev/null || exit 1
        fi
fi

# -----------------------------------------------------
# Components Installation
# -----------------------------------------------------
echo ""
echo "Installing required components..."
echo ""

# TODO

# -----------------------------------------------------
# Developer Platform Configuration
# -----------------------------------------------------
echo ""
echo "Configuring Developer Platform..."
echo ""

# TODO

# -----------------------------------------------------
# Setup completed
# -----------------------------------------------------

echo ""
echo "========================================="
echo " Setup completed successfully!"
echo "========================================="
echo ""
echo "Developer Platform is ready to use."
echo ""
echo "Next steps:"
echo "  1. source scripts/load-env.sh"
echo "  2. Start Backstage"
echo "  3. Start Platform API"
echo ""