#!/bin/bash

# =====================================================
# Developer Platform Setup
# =====================================================

# -----------------------------------------------------
# Platform Runtime Versions
# -----------------------------------------------------

JAVA_TARGET_VERSION="21"

NVM_TARGET_VERSION="v0.40.3"

NODE_TARGET_VERSION="lts/*"

DOCKER_DESKTOP_PATH="/mnt/c/Program Files/Docker/Docker"

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

# -----------------------------------------------------
# Java
# -----------------------------------------------------

if command -v java >/dev/null 2>&1; then
    INSTALLED_JAVA_VERSION="$(
        java -version 2>&1 |
        head -n 1 |
        sed -E 's/.*"([^"]+)".*/\1/'
    )"

    echo "✓ Java ($INSTALLED_JAVA_VERSION)"

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
            INSTALLED_JAVA_VERSION="$(
                java -version 2>&1 |
                head -n 1 |
                sed -E 's/.*"([^"]+)".*/\1/'
            )"

            echo ""
            echo "✓ Java ($INSTALLED_JAVA_VERSION)"
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
# Maven
# -----------------------------------------------------

if command -v mvn >/dev/null 2>&1; then

    INSTALLED_MAVEN_VERSION="$(
        mvn -version |
        head -n 1 |
        sed -E 's/Apache Maven ([0-9.]+).*/\1/'
    )"

    echo "✓ Maven ($INSTALLED_MAVEN_VERSION)"

else

    echo "✗ Maven"
    echo ""

    echo "Apache Maven is required by the Developer Platform."
    echo ""

    read -rp "Install Apache Maven now? [y/N]: " INSTALL_MAVEN

    if [[ "$INSTALL_MAVEN" =~ ^[Yy]$ ]]; then

        echo ""
        echo "Installing Apache Maven..."
        echo ""

        sudo apt install -y maven

        if command -v mvn >/dev/null 2>&1; then

            INSTALLED_MAVEN_VERSION="$(
                mvn -version |
                head -n 1 |
                sed -E 's/Apache Maven ([0-9.]+).*/\1/'
            )"

            echo "✓ Maven ($INSTALLED_MAVEN_VERSION)"

        else

            echo ""
            echo "ERROR: Maven installation failed."

            return 1 2>/dev/null || exit 1

    fi

    else

        echo ""
        echo "Maven installation skipped."

        return 1 2>/dev/null || exit 1

    fi

fi

# -----------------------------------------------------
# Node.js Runtime
# -----------------------------------------------------
echo ""
echo "Node.js Runtime:"

# -----------------------------------------------------
# NVM
# -----------------------------------------------------

if [[ -n "$NVM_DIR" && -s "$NVM_DIR/nvm.sh" ]]; then

    # Load NVM into the current shell
    . "$NVM_DIR/nvm.sh"

    INSTALLED_NVM_VERSION="$(nvm --version)"

    echo "✓ NVM ($INSTALLED_NVM_VERSION)"

else

    echo "✗ NVM"
    echo ""

    echo "Node.js Runtime is required by the Developer Platform."
    echo ""

    read -rp "Install Node.js Runtime now? [y/N]: " INSTALL_NODE_RUNTIME

    if [[ "$INSTALL_NODE_RUNTIME" =~ ^[Yy]$ ]]; then

        echo ""
        echo "Installing Node.js Runtime..."
        echo ""

        echo "Installing NVM..."
        echo ""
        curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_TARGET_VERSION}/install.sh" | bash

        export NVM_DIR="$HOME/.nvm"

        if [[ -s "$NVM_DIR/nvm.sh" ]]; then
            . "$NVM_DIR/nvm.sh"
        fi

        if command -v nvm >/dev/null 2>&1; then

            INSTALLED_NVM_VERSION="$(nvm --version)"

            echo ""
            echo "✓ NVM ($INSTALLED_NVM_VERSION)"

        else

            echo ""
            echo "ERROR: NVM installation failed."

            return 1 2>/dev/null || exit 1

        fi

        echo ""
        echo "Installing Node.js..."
        echo ""

        if ! nvm install "$NODE_TARGET_VERSION"; then

            echo ""
            echo "ERROR: Node.js installation failed."

            return 1 2>/dev/null || exit 1

        fi

    else

        echo ""
        echo "Node.js Runtime installation skipped."

        return 1 2>/dev/null || exit 1

    fi

fi

# -----------------------------------------------------
# Node.js
# -----------------------------------------------------

if command -v node >/dev/null 2>&1; then

    INSTALLED_NODE_VERSION="$(node --version)"

    echo "✓ Node.js (${INSTALLED_NODE_VERSION#v})"

else

    echo "✗ Node.js"

fi

# -----------------------------------------------------
# npm
# -----------------------------------------------------

if command -v npm >/dev/null 2>&1; then

    INSTALLED_NPM_VERSION="$(npm --version)"

    echo "✓ npm ($INSTALLED_NPM_VERSION)"

else

    echo "✗ npm"

fi

# -----------------------------------------------------
# Docker
# -----------------------------------------------------

echo ""
echo "Docker:"

# -----------------------------------------------------
# Docker CLI
# -----------------------------------------------------

if docker --version >/dev/null 2>&1; then

    INSTALLED_DOCKER_VERSION="$(
        docker --version |
        sed -E 's/Docker version ([^,]+),.*/\1/'
    )"

    echo "✓ Docker ($INSTALLED_DOCKER_VERSION)"

else

    echo "✗ Docker"
    echo ""

    # -------------------------------------------------
    # Docker Desktop Detection
    # -------------------------------------------------

    if [ -f "$DOCKER_DESKTOP_PATH/Docker Desktop.exe" ]; then

        echo "✓ Docker Desktop installed"
        echo ""

        # ---------------------------------------------
        # Docker Desktop Guidance
        # ---------------------------------------------

        echo "Docker Desktop is currently not running."
        echo ""
        echo "Please start Docker Desktop."
        echo ""
        echo "Run ./scripts/setup.sh again after Docker Desktop is running."

    else

        echo "✗ Docker Desktop not installed"
        echo ""

        # ---------------------------------------------
        # Docker Desktop Installation Guidance
        # ---------------------------------------------

        echo "Please install Docker Desktop for Windows."
        echo ""
        echo "After installation:"
        echo "  1. Enable WSL integration."
        echo "  2. Restart WSL."
        echo "  3. Execute setup.sh again."

    fi

    return 1 2>/dev/null || exit 1

fi

# -----------------------------------------------------
# Docker Compose
# -----------------------------------------------------

if docker compose version >/dev/null 2>&1; then

    INSTALLED_DOCKER_COMPOSE_VERSION="$(
        docker compose version |
        sed -E 's/Docker Compose version v?([^ ]+).*/\1/'
    )"

    echo "✓ Docker Compose ($INSTALLED_DOCKER_COMPOSE_VERSION)"

else

    echo "✗ Docker Compose"

fi

# -----------------------------------------------------
# Yarn
# -----------------------------------------------------

echo ""
echo "Yarn:"

if yarn --version >/dev/null 2>&1; then

    echo "✓ Yarn ($(yarn --version))"

else

    echo "✗ Yarn"
    echo ""

    read -rp "Install Yarn now? [y/N]: " INSTALL_YARN

    if [[ "$INSTALL_YARN" =~ ^[Yy]$ ]]; then

        echo ""
        echo "Installing Yarn..."
        echo ""

        npm install --global yarn

        echo ""

        if yarn --version >/dev/null 2>&1; then

            echo "✓ Yarn ($(yarn --version))"

        else

        echo "✗ Failed to install Yarn."

        return 1 2>/dev/null || exit 1

    fi

    else

        echo ""
        echo "Yarn installation skipped."

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