#!/bin/bash
BASE_DIR="$(dirname "$(readlink -f "$0")")"

## Credentials
# Git config
[ ! -f "$HOME/.gitconfig" ] && ln -sf "$BASE_DIR/.gitconfig" "$HOME/.gitconfig"

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

# Neovim
if [ -x "$(command -v nvim)" ]; then
    [ ! -d "$HOME/.config" ] && mkdir "$HOME/.config"
    ln -sf "$BASE_DIR/nvim" "$HOME/.config/nvim"
fi

# Zsh
[ ! -f "$HOME/.hushlogin" ] && touch "$HOME/.hushlogin"
if [ -x "$(command -v zsh)" ]; then
    ln -sf "$BASE_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
    ln -sf "$BASE_DIR/.zshenv" "$HOME/.zshenv"
    ln -sf "$BASE_DIR/.zshrc" "$HOME/.zshrc"
fi
