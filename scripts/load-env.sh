#!/bin/bash

# =====================================================
# Developer Platform Bootstrap
# =====================================================

# -----------------------------------------------------
# Locate project root
# -----------------------------------------------------

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
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
    exit 1
fi

# -----------------------------------------------------
# Load environment variables
# -----------------------------------------------------

echo "Loading Developer Platform environment..."

set -a
source "$ENV_FILE"
set +a

echo "Environment loaded successfully."

# -----------------------------------------------------
# Validate required variables
# -----------------------------------------------------

# TODO: Sprint 2 - Commit 2

# -----------------------------------------------------
# Print environment summary
# -----------------------------------------------------

# TODO: Sprint 2 - Commit 3