#!/bin/bash
set -e

CAVEMAN_REPO="https://github.com/JuliusBrussee/caveman.git"
CAVEMAN_DIR="$HOME/GitHub/caveman"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Caveman skill setup ==="

# Clone caveman repo if not already present
if [ ! -d "$CAVEMAN_DIR" ]; then
    echo "Cloning caveman repo..."
    mkdir -p "$(dirname "$CAVEMAN_DIR")"
    git clone "$CAVEMAN_REPO" "$CAVEMAN_DIR"
else
    echo "Caveman repo already exists at $CAVEMAN_DIR"
    cd "$CAVEMAN_DIR" && git pull
fi

# Create symlink
if [ ! -L "$SCRIPT_DIR/skills" ]; then
    echo "Creating symlink: $SCRIPT_DIR/skills → $CAVEMAN_DIR/skills"
    ln -s "$CAVEMAN_DIR/skills" "$SCRIPT_DIR/skills"
else
    echo "Symlink already exists"
fi

echo "=== Done. /caveman skills ready. ==="
