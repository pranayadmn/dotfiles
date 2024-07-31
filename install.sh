#!/bin/bash
BASE_DIR="$(dirname "$(readlink -f "$0")")"

## Credentials
# Git config
if [ ! -f "$HOME/.gitconfig" ]; then
    ln -sf "$BASE_DIR/.gitconfig" "$HOME/.gitconfig"
    [ ! -d "$HOME/.git" ] && mkdir "$HOME/.git"
    ln -sf "$BASE_DIR/git-hooks" "$HOME/.git/hooks"
fi

# GnuPG key
if [ -d "$BASE_DIR/keys/gpg" ] && [ -x "$(command -v gpg)" ]; then
    gpg --import "$BASE_DIR/keys/gpg/370A31FC9F6948FC.gpg"
fi

# SSH key
if [ -d "$BASE_DIR/keys/ssh" ]; then
    [ ! -d "$HOME/.ssh" ] && mkdir "$HOME/.ssh"
    ln -sf "$BASE_DIR/keys/ssh/id_ed25519" "$HOME/.ssh/id_ed25519"
    ln -sf "$BASE_DIR/keys/ssh/id_ed25519.pub" "$HOME/.ssh/id_ed25519.pub"
fi

## Configuration
# Nano
if [ -x "$(command -v nano)" ]; then
    if [ -z "$PREFIX" ]; then
        if [ "$EUID" -ne 0 ]; then
            sudo ln -sf "$BASE_DIR/etc/nanorc" /etc/nanorc
        else
            ln -sf "$BASE_DIR/etc/nanorc" /etc/nanorc
        fi
    else
        ln -sf "$BASE_DIR/etc/nanorc.termux" "$PREFIX/etc/nanorc"
    fi
    ln -sf "$BASE_DIR/.nanorc" "$HOME/.nanorc"
fi

# Zsh
[ ! -f "$HOME/.hushlogin" ] && touch "$HOME/.hushlogin"
if [ -x "$(command -v zsh)" ]; then
    ln -sf "$BASE_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
    ln -sf "$BASE_DIR/.zshenv" "$HOME/.zshenv"
    ln -sf "$BASE_DIR/.zshrc" "$HOME/.zshrc"
fi
