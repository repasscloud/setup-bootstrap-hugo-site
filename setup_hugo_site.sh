#!/bin/bash

# Check if a directory name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

TARGET_DIR=$1

# Step 1: Clone the git theme URL into the target directory
git clone  https://github.com/repasscloud/setup-bootstrap-hugo-site.git "$TARGET_DIR"

# Step 2: Navigate into the directory
cd "$TARGET_DIR"

# Step 3: Copy the contents of exampleSite to the root of the project
cp -r exampleSite/* .

# Step 4: Remove the exampleSite directory
rm -rf exampleSite

# Step 5: Modify config.toml to update baseURL and timeZone, and add params
CONFIG_FILE=./config/_default/config.toml

# Replace baseURL
sed -i.bak "s|baseURL = 'https://filipecarneiro.github.io/hugo-bootstrap-theme/'|baseURL = ''|" "$CONFIG_FILE"

# Replace timeZone
sed -i.bak "s|timeZone = 'Europe/London'|timeZone = 'Australia/Sydney'|" "$CONFIG_FILE"

# Add params at the bottom
cat <<EOL >> "$CONFIG_FILE"

[params]
  mainButtonURL = "https://example.com/get-started"  # Set your desired URL here
  mainButtonText = "Get Started"
EOL

# Step 6: Modify index.html to use the params for the button
INDEX_FILE=./layouts/index.html

# Replace the href and text in the button link
sed -i.bak 's|<a class="btn btn-bd-primary btn-lg px-4 mb-2" href="https://github.com/filipecarneiro/hugo-bootstrap-theme" role="button">Get Started</a>|<a class="btn btn-bd-primary btn-lg px-4 mb-2" href="{{ .Site.Params.mainButtonURL }}" role="button">{{ .Site.Params.mainButtonText }}</a>|' "$INDEX_FILE"

echo "Setup complete. You can now run 'hugo server -D --disableFastRender' to start your site."

