#!/bin/bash

# Directory this script is in
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="$HOME/.config/wezterm"

# Desired link target
LINK_TARGET=$SCRIPT_DIR

if [ -L "$TARGET" ]; then
    # It's a link
    CURRENT_TARGET="$(readlink "$TARGET")"
    if [ "$CURRENT_TARGET" != "$LINK_TARGET" ]; then
        echo "Symlink exists but points to $CURRENT_TARGET. Updating to $LINK_TARGET."
        rm "$TARGET"
        ln -s "$LINK_TARGET" "$TARGET"
        echo "Wezterm set up."
    else
        echo "Symlink points to $LINK_TARGET. Wezterm is already set up."
    fi
elif [ -d "$TARGET" ]; then
    # It's a directory, not a symlink
    echo "$TARGET is a directory. Removing and linking it to $TARGET"
    # TODO: maybe move it to another place as a backup!?
    rm -rf "$TARGET"
    ln -s "$LINK_TARGET" "$TARGET"
    echo "Wezterm set up."
elif [ -e "$TARGET" ]; then
    # Something else (i.e file, socket, etc.)
    echo "$TARGET exists but is not a directory or symlink. Removing and linking it to $TARGET"
    rm -rf "$TARGET"
    ln -s "$LINK_TARGET" "$TARGET"
    echo "Wezterm set up."
else
    # Doesn't exist 
    echo "$TARGET does not exist. Creating symlink"
    ln -s "$LINK_TARGET" "$TARGET"
    echo "Wezterm set up."
fi
