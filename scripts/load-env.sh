#!/bin/bash

# =====================================================
# Developer Platform Bootstrap
# =====================================================

# -----------------------------------------------------
# Bootstrap banner
# -----------------------------------------------------

echo "========================================="
echo " Developer Platform Bootstrap"
echo "========================================="
echo ""

# -----------------------------------------------------
# Validate execution mode
# -----------------------------------------------------

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "ERROR: This script must be sourced."
    echo ""
    echo "Use:"
    echo "  source scripts/load-env.sh"

    return 1 2>/dev/null || exit 1
fi

# -----------------------------------------------------
# Locate project root
# -----------------------------------------------------

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

ENV_FILE="$PROJECT_ROOT/.env"

# -----------------------------------------------------
# Validate .env file
# -----------------------------------------------------

if [ ! -f "$ENV_FILE" ]; then
    echo "ERROR: .env file not found."
    echo ""
    echo "Expected location:"
    echo "  $ENV_FILE"
    echo ""
    echo "Create it from:"
    echo "  cp .env.example .env"

    return 1 2>/dev/null || exit 1
fi

# -----------------------------------------------------
# Load environment variables
# -----------------------------------------------------

echo "Loading environment..."
echo ""

set -a
source "$ENV_FILE"
set +a

echo "Environment loaded successfully."
echo ""

# -----------------------------------------------------
# Validate required variables
# -----------------------------------------------------

REQUIRED_VARS=(
    GITHUB_TOKEN
    GHCR_USERNAME
    MINIKUBE_PROFILE
    BACKSTAGE_PORT
    PLATFORM_API_PORT
)

echo "Checking required variables..."
echo ""

for VAR in "${REQUIRED_VARS[@]}"; do

    if [ -z "${!VAR}" ]; then
        echo "✗ $VAR"
        echo ""
        echo "ERROR: Required variable '$VAR' is not configured."
        echo ""
        echo "Please update:"
        echo "  $ENV_FILE"

        return 1 2>/dev/null || exit 1
    fi

    echo "✓ $VAR"

done

# -----------------------------------------------------
# Bootstrap completed
# -----------------------------------------------------

echo ""
echo "Bootstrap completed successfully."