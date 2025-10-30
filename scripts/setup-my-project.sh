#!/bin/bash
# Usage: bash scripts/setup-my-project.sh BACKEND_FOLDER FRONTEND_FOLDER PACKAGE_NAME

set -e
BACKEND_FOLDER="$1"
FRONTEND_FOLDER="$2"
PACKAGE_NAME="$3"

if [[ -z "$BACKEND_FOLDER" || -z "$FRONTEND_FOLDER" || -z "$PACKAGE_NAME" ]]; then
  echo "Usage: $0 <backend-folder> <frontend-folder> <java-package-name>"
  echo "Ex:   $0 pranish-backend pranish-frontend edu.belmont.pranish"
  exit 1
fi

# Step 1: Rename folders (if needed, uses git to preserve history)
if [ -d custom-backend-name ]; then
  git mv custom-backend-name "$BACKEND_FOLDER"
fi
if [ -d custom-frontend-name ]; then
  git mv custom-frontend-name "$FRONTEND_FOLDER"
fi

# Step 2: Set up .env
cat > .env <<EOF
BACKEND_FOLDER=$BACKEND_FOLDER
FRONTEND_FOLDER=$FRONTEND_FOLDER
EOF

# Step 3: Update docker-compose.full.yml
COMPOSE="docs/for-developers/docker-compose.full.yml"
sed -i '' \
  -e "s|context: ../../[a-zA-Z0-9_-]*backend[a-zA-Z0-9_-]*|context: ../../$BACKEND_FOLDER|g" \
  -e "s|context: ../../[a-zA-Z0-9_-]*frontend[a-zA-Z0-9_-]*|context: ../../$FRONTEND_FOLDER|g" \
  -e "s|container_name: [a-zA-Z0-9_-]*backend[a-zA-Z0-9_-]*|container_name: $BACKEND_FOLDER|g" \
  -e "s|container_name: [a-zA-Z0-9_-]*frontend[a-zA-Z0-9_-]*|container_name: $FRONTEND_FOLDER|g" \
  "$COMPOSE"

# Step 4: Move Java package directories and update declarations
pushd "$BACKEND_FOLDER/src/main/java" > /dev/null

PKG_PATH="$(echo $PACKAGE_NAME | tr . /)"
if [ ! -d $PKG_PATH ]; then
  mkdir -p $PKG_PATH
fi
if [ -d com/example/simpleloginbackend ]; then
  mv com/example/simpleloginbackend/* $PKG_PATH/
  rm -rf com
fi
popd > /dev/null

# Test
if [ -d "$BACKEND_FOLDER/src/test/java/com/example/simpleloginbackend" ]; then
  pushd "$BACKEND_FOLDER/src/test/java" > /dev/null
  mkdir -p $PKG_PATH
  mv com/example/simpleloginbackend/* $PKG_PATH/
  rm -rf com
  popd > /dev/null
fi

# Step 5: Update package declarations in Java files
grep -rl "package com.example.simpleloginbackend" "$BACKEND_FOLDER/src/main/java/$PKG_PATH" | xargs sed -i '' "s|package com.example.simpleloginbackend;|package $PACKAGE_NAME;|g"
grep -rl "package com.example.simpleloginbackend" "$BACKEND_FOLDER/src/test/java/$PKG_PATH" | xargs sed -i '' "s|package com.example.simpleloginbackend;|package $PACKAGE_NAME;|g" 2>/dev/null || true

# Step 5b: Update import statements in Java files
find "$BACKEND_FOLDER/src/main/java/$PKG_PATH" -type f -name '*.java' -exec sed -i '' "s|import com.example.simpleloginbackend|import $PACKAGE_NAME|g" {} +
find "$BACKEND_FOLDER/src/test/java/$PKG_PATH" -type f -name '*.java' -exec sed -i '' "s|import com.example.simpleloginbackend|import $PACKAGE_NAME|g" {} + 2>/dev/null || true

# Step 6: Update Maven groupId and artifactId
POM="$BACKEND_FOLDER/pom.xml"
sed -i '' "s|<groupId>.*</groupId>|<groupId>$PACKAGE_NAME</groupId>|" "$POM"
sed -i '' "s|<artifactId>.*</artifactId>|<artifactId>$BACKEND_FOLDER</artifactId>|" "$POM"

# Step 7: Update logging config
APP_PROPS="$BACKEND_FOLDER/src/main/resources/application.properties"
sed -i '' "s|logging.level.com.example.simpleloginbackend=INFO|logging.level.$PACKAGE_NAME=INFO|g" "$APP_PROPS"

# Step 8: Install frontend deps
pushd "$FRONTEND_FOLDER" > /dev/null
npm ci
popd > /dev/null

echo "\n✨ Project customized successfully!\n"
echo "Backend folder: $BACKEND_FOLDER\nFrontend folder: $FRONTEND_FOLDER\nJava package: $PACKAGE_NAME\n"
echo "Run: bash scripts/dev.sh"
echo "Frontend: http://localhost:5173  |  Backend API: http://localhost:8080/api"
