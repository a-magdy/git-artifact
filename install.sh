#!/bin/bash

# git-artifact installation script

# Run using: curl -fsSL https://raw.githubusercontent.com/praqma/git-artifact/main/install.sh | bash
#
# Or
# Download and review first
# curl -o install.sh https://raw.githubusercontent.com/praqma/git-artifact/main/install.sh
# cat install.sh  # Review the script
# chmod +x install.sh && ./install.sh

set -e

# Default installation directories
BIN_DIR="${HOME}/.local/bin"
MAN_DIR="${HOME}/.local/share/man/man1"
REPO_URL="https://raw.githubusercontent.com/praqma/git-artifact/main"

# Create directories if they don't exist
mkdir -p "$BIN_DIR"
mkdir -p "$MAN_DIR"

echo "Installing git-artifact..."

# Download the main script
echo "Downloading git-artifact binary..."
curl -fsSL -o "$BIN_DIR/git-artifact" "$REPO_URL/git-artifact"
chmod +x "$BIN_DIR/git-artifact"

# Download the man page
echo "Downloading man page..."
curl -fsSL -o "$MAN_DIR/git-artifact.1" "$REPO_URL/git-artifact.1"

# Update MANPATH if needed
if ! echo "$MANPATH" | grep -q "$HOME/.local/share/man"; then
    echo "Adding ~/.local/share/man to MANPATH..."
    
    # Determine which shell config file to update
    if [[ "$SHELL" == *"zsh"* ]]; then
        SHELL_CONFIG="$HOME/.zshrc"
    else
        SHELL_CONFIG="$HOME/.bashrc"
    fi
    
    echo 'export MANPATH="$HOME/.local/share/man:$MANPATH"' >> "$SHELL_CONFIG"
    export MANPATH="$HOME/.local/share/man:$MANPATH"
fi

# Update PATH if needed
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "Adding ~/.local/bin to PATH..."
    
    # Determine which shell config file to update
    if [[ "$SHELL" == *"zsh"* ]]; then
        SHELL_CONFIG="$HOME/.zshrc"
    else
        SHELL_CONFIG="$HOME/.bashrc"
    fi
    
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_CONFIG"
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "Installation complete!"
echo ""
echo "Please restart your terminal or run:"
if [[ "$SHELL" == *"zsh"* ]]; then
    echo "  source ~/.zshrc"
else
    echo "  source ~/.bashrc"
fi
echo ""
echo "Then test with:"
echo "  git artifact -h        # Shows built-in help"
echo "  git artifact --help    # Shows man page"
echo "  man git-artifact       # Shows man page directly"
