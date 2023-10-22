## Environment variables
# Set nano/neovim as the default editor
if [[ -x "$(command -v nvim)" ]]; then
    export EDITOR=nvim
else
    export EDITOR=nano
fi

# Set up GPG_TTY for GnuPG signing
export GPG_TTY=$TTY

# Use ccache to speed up subsequent builds
if [[ -x "$(command -v ccache)" ]]; then
    export USE_CCACHE=1
    export CCACHE_DIR="$HOME/.ccache"
    export CCACHE_EXEC=$(command -v ccache)
fi

# Add cargo and pipx packages to PATH
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.local/bin"
