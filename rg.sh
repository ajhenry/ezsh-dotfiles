#!/bin/bash

# Currently unused because I use brew to install ripgrep

# Define the GitHub repository
REPO="BurntSushi/ripgrep"

# Fetch the latest release tag from GitHub API
LATEST_VERSION=$(curl -s https://api.github.com/repos/$REPO/releases/latest | grep 'tag_name' | cut -d\" -f4)

# Construct the download URL
URL="https://github.com/$REPO/releases/download/$LATEST_VERSION/ripgrep-$LATEST_VERSION-aarch64-apple-darwin.tar.gz"

# Download the latest release tar.gz
echo "Downloading ripgrep version $LATEST_VERSION..."
curl -LO "$URL"

# Extract the downloaded tar.gz file
TAR_FILE="ripgrep-$LATEST_VERSION-aarch64-apple-darwin.tar.gz"
echo "Extracting $TAR_FILE..."
tar -xzf "$TAR_FILE"

# Move the rg binary to /usr/local/bin
echo "Moving rg binary to /usr/local/bin..."
sudo mv "ripgrep-$LATEST_VERSION-aarch64-apple-darwin/rg" /usr/local/bin/

# Clean up the downloaded files
echo "Cleaning up..."
rm -rf "ripgrep-$LATEST_VERSION-aarch64-apple-darwin" "$TAR_FILE"

# Verify the installation
echo "Verifying the installation..."
rg --version

echo "ripgrep $LATEST_VERSION has been successfully installed!"
