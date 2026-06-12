#!/bin/bash

# ==============================
# INPUTS
# ==============================

SERVICE_NAME=$1
PACKAGE_NAME=$2
CONTAINER_PORT=$3
NODE_PORT=$4
TARGET_PATH=$5

# ==============================
# VALIDATION
# ==============================

if [ -z "$SERVICE_NAME" ]; then
  echo "Usage:"
  echo "./generate.sh service-name package.name 8080 30007"
  exit 1
fi

# ==============================
# VARIABLES
# ==============================

TEMPLATE_DIR=~/platform/templates/springboot-api
TARGET_DIR=$TARGET_PATH

PACKAGE_PATH=$(echo $PACKAGE_NAME | tr '.' '/')

# ==============================
# COPY TEMPLATE
# ==============================

echo "Creating project..."

mkdir -p $TARGET_DIR

cp -r $TEMPLATE_DIR/app/. $TARGET_DIR/

# ==============================
# CREATE .github/workflows
# ==============================

mkdir -p $TARGET_DIR/.github/workflows

cp $TEMPLATE_DIR/github/ci.yml \
$TARGET_DIR/.github/workflows/ci.yml

# ==============================
# CREATE K8S STRUCTURE
# ==============================

mkdir -p ~/platform/k8s/$SERVICE_NAME

cp $TEMPLATE_DIR/k8s/* \
~/platform/k8s/$SERVICE_NAME/

# ==============================
# REPLACE PLACEHOLDERS
# ==============================

echo "Replacing placeholders..."

find $TARGET_DIR -type f -exec sed -i "s|{{SERVICE_NAME}}|$SERVICE_NAME|g" {} \;

find $TARGET_DIR -type f -exec sed -i "s|{{PACKAGE_NAME}}|$PACKAGE_NAME|g" {} \;

find $TARGET_DIR -type f -exec sed -i "s|{{PACKAGE_GROUP}}|$(echo $PACKAGE_NAME | awk -F'.' '{print $1"."$2}')|g" {} \;

find $TARGET_DIR -type f -exec sed -i "s|{{CONTAINER_PORT}}|$CONTAINER_PORT|g" {} \;

find $TARGET_DIR -type f -exec sed -i "s|{{NODE_PORT}}|$NODE_PORT|g" {} \;

find $TARGET_DIR -type f -exec sed -i "s|{{IMAGE_NAME}}|ghcr.io/marcelphilippeandrade/$SERVICE_NAME|g" {} \;

# ==============================
# REPLACE K8S FILES
# ==============================

find ~/platform/k8s/$SERVICE_NAME -type f -exec sed -i "s|{{SERVICE_NAME}}|$SERVICE_NAME|g" {} \;

find ~/platform/k8s/$SERVICE_NAME -type f -exec sed -i "s|{{CONTAINER_PORT}}|$CONTAINER_PORT|g" {} \;

find ~/platform/k8s/$SERVICE_NAME -type f -exec sed -i "s|{{NODE_PORT}}|$NODE_PORT|g" {} \;

find ~/platform/k8s/$SERVICE_NAME -type f -exec sed -i "s|{{IMAGE_NAME}}|ghcr.io/marcelphilippeandrade/$SERVICE_NAME|g" {} \;

# ==============================
# REORGANIZE JAVA PACKAGE
# ==============================

echo "Reorganizing Java packages..."

mkdir -p $TARGET_DIR/src/main/java/$PACKAGE_PATH

cp -r $TARGET_DIR/src/main/java/com/example/demo/. \
$TARGET_DIR/src/main/java/$PACKAGE_PATH/

rm -rf $TARGET_DIR/src/main/java/com/example

# ==============================
# DONE
# ==============================

echo "===================================="
echo "Project created successfully!"
echo "===================================="

echo "Project: $SERVICE_NAME"
echo "Package: $PACKAGE_NAME"
echo "Port: $CONTAINER_PORT"

echo ""
echo "Location:"
echo "$TARGET_DIR"
