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

# Step 1: Ensure backend/frontend folders exist; rename from common defaults if needed
# Determine and move backend folder
if [ ! -d "$BACKEND_FOLDER" ]; then
  for CANDIDATE in custom-backend-name your-backend-folder pranish-demo-backend simple-login-backend backend; do
    if [ -d "$CANDIDATE" ]; then
      if command -v git >/dev/null 2>&1; then
        git mv "$CANDIDATE" "$BACKEND_FOLDER"
      else
        mv "$CANDIDATE" "$BACKEND_FOLDER"
      fi
      break
    fi
  done
fi

# Determine and move frontend folder
if [ ! -d "$FRONTEND_FOLDER" ]; then
  for CANDIDATE in custom-frontend-name your-frontend-folder pranish-demo-frontend simple-login-frontend frontend; do
    if [ -d "$CANDIDATE" ]; then
      if command -v git >/dev/null 2>&1; then
        git mv "$CANDIDATE" "$FRONTEND_FOLDER"
      else
        mv "$CANDIDATE" "$FRONTEND_FOLDER"
      fi
      break
    fi
  done
fi

# Validate folders now exist
if [ ! -d "$BACKEND_FOLDER" ]; then
  echo "[ERROR] Could not find or create backend folder '$BACKEND_FOLDER'." >&2
  echo "        Pass the CURRENT backend folder name as the first argument (e.g., 'your-backend-folder')," >&2
  echo "        or rename your folder before running this script." >&2
  exit 1
fi
if [ ! -d "$FRONTEND_FOLDER" ]; then
  echo "[ERROR] Could not find or create frontend folder '$FRONTEND_FOLDER'." >&2
  echo "        Pass the CURRENT frontend folder name as the second argument (e.g., 'your-frontend-folder')," >&2
  echo "        or rename your folder before running this script." >&2
  exit 1
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
if [ -d "$BACKEND_FOLDER/src/main/java/$PKG_PATH" ]; then
  grep -rl "package com.example.simpleloginbackend" "$BACKEND_FOLDER/src/main/java/$PKG_PATH" 2>/dev/null | xargs sed -i '' "s|package com.example.simpleloginbackend;|package $PACKAGE_NAME;|g" 2>/dev/null || true
fi
if [ -d "$BACKEND_FOLDER/src/test/java/$PKG_PATH" ]; then
  grep -rl "package com.example.simpleloginbackend" "$BACKEND_FOLDER/src/test/java/$PKG_PATH" 2>/dev/null | xargs sed -i '' "s|package com.example.simpleloginbackend;|package $PACKAGE_NAME;|g" 2>/dev/null || true
fi

# Step 5b: Update import statements in Java files
if [ -d "$BACKEND_FOLDER/src/main/java/$PKG_PATH" ]; then
  find "$BACKEND_FOLDER/src/main/java/$PKG_PATH" -type f -name '*.java' -exec sed -i '' "s|import com.example.simpleloginbackend|import $PACKAGE_NAME|g" {} + 2>/dev/null || true
fi
if [ -d "$BACKEND_FOLDER/src/test/java/$PKG_PATH" ]; then
  find "$BACKEND_FOLDER/src/test/java/$PKG_PATH" -type f -name '*.java' -exec sed -i '' "s|import com.example.simpleloginbackend|import $PACKAGE_NAME|g" {} + 2>/dev/null || true
fi

# Step 6: Update Maven groupId and artifactId
POM="$BACKEND_FOLDER/pom.xml"
# If a Spring Boot parent is not present, ensure valid Boot parent and coordinates
if ! grep -q "spring-boot-starter-parent" "$POM" 2>/dev/null; then
  cat > "$POM" <<'EOPOM'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.5.7</version>
    <relativePath/>
  </parent>
  <groupId>$PACKAGE_NAME</groupId>
  <artifactId>$BACKEND_FOLDER</artifactId>
  <version>0.0.1-SNAPSHOT</version>
  <name>$BACKEND_FOLDER</name>
  <description>Simple Login Backend</description>
  <properties>
    <java.version>21</java.version>
  </properties>
  <dependencies>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-data-mongodb</artifactId>
    </dependency>
    <dependency>
      <groupId>io.jsonwebtoken</groupId>
      <artifactId>jjwt-api</artifactId>
      <version>0.11.5</version>
    </dependency>
    <dependency>
      <groupId>io.jsonwebtoken</groupId>
      <artifactId>jjwt-impl</artifactId>
      <version>0.11.5</version>
      <scope>runtime</scope>
    </dependency>
    <dependency>
      <groupId>io.jsonwebtoken</groupId>
      <artifactId>jjwt-jackson</artifactId>
      <version>0.11.5</version>
      <scope>runtime</scope>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-devtools</artifactId>
      <scope>runtime</scope>
      <optional>true</optional>
    </dependency>
    <dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <optional>true</optional>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-test</artifactId>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <build>
    <plugins>
      <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
      </plugin>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.13.0</version>
        <configuration>
          <source>${java.version}</source>
          <target>${java.version}</target>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
EOPOM
else
  # Safely update only the project's groupId and artifactId (do not touch <parent>)
  TMP_POM=$(mktemp)
  awk '
    BEGIN { inside_parent=0; replaced_g=0; replaced_a=0 }
    /<parent>/ { inside_parent=1 }
    /<\/parent>/ { inside_parent=0 }
    {
      if (!inside_parent && !replaced_g && match($0, /<groupId>[^<]*<\/groupId>/)) {
        sub(/<groupId>[^<]*<\/groupId>/, "<groupId>'"$PACKAGE_NAME"'</groupId>")
        replaced_g=1
      } else if (!inside_parent && !replaced_a && match($0, /<artifactId>[^<]*<\/artifactId>/)) {
        sub(/<artifactId>[^<]*<\/artifactId>/, "<artifactId>'"$BACKEND_FOLDER"'</artifactId>")
        replaced_a=1
      }
      print
    }
  ' "$POM" > "$TMP_POM" && mv "$TMP_POM" "$POM"
fi

# Step 7: Update Spring app name to reflect chosen backend folder
APP_PROPS="$BACKEND_FOLDER/src/main/resources/application.properties"
if [ -f "$APP_PROPS" ]; then
  if grep -q "^spring.application.name=" "$APP_PROPS"; then
    sed -i '' "s|^spring.application.name=.*|spring.application.name=$BACKEND_FOLDER|" "$APP_PROPS"
  else
    echo "spring.application.name=$BACKEND_FOLDER" >> "$APP_PROPS"
  fi
fi

# Step 8: Install frontend deps
pushd "$FRONTEND_FOLDER" > /dev/null
npm ci
popd > /dev/null

echo "\n✨ Project customized successfully!\n"
echo "Backend folder: $BACKEND_FOLDER\nFrontend folder: $FRONTEND_FOLDER\nJava package: $PACKAGE_NAME\n"
echo "Run: bash scripts/dev.sh"
echo "Frontend: http://localhost:5173  |  Backend API: http://localhost:8080/api"
