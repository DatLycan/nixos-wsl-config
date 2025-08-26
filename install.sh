#!/bin/sh
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
fi

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: sudo sh $0 <username> <target_config>" >&2
    exit 1
fi

NIXOS_DIR="/etc/nixos"
GIT_REPO="https://github.com/DatLycan/nixos-wsl-config.git"
GIT_FLAKE="github:Datlycan/nixos-wsl-config"
USER_NAME="$1"
TARGET_CONFIG="$2"

AVAILABLE_CONFIGS=$(nix flake show --json "$GIT_FLAKE" --no-write-lock-file 2> /dev/null | jq -r '.nixosConfigurations | keys[]')

if ! echo "$AVAILABLE_CONFIGS" | grep -qx "$TARGET_CONFIG"; then
    echo -e "Invalid configuration: $TARGET_CONFIG\n" >&2
    echo -e "Available options:\n$AVAILABLE_CONFIGS" >&2
    exit 1
fi

rm -rf "$NIXOS_DIR"
git clone "$GIT_REPO" "$NIXOS_DIR"

sed -i "s/datlycan/$USER_NAME/g" "$NIXOS_DIR/settings.nix"

nixos-rebuild switch --flake /etc/nixos#"$TARGET_CONFIG" --show-trace