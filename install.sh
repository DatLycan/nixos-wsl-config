#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
fi

set -e

NIXOS_DIR="/etc/nixos"
GIT_REPO="https://github.com/DatLycan/nixos-wsl-config.git"
GIT_FLAKE="github:Datlycan/nixos-wsl-config"
AVAILABLE_CONFIGS=$(nix flake show --json "$GIT_FLAKE" --no-write-lock-file 2> /dev/null | jq -r '.nixosConfigurations | keys[]') 

echo -e "\nAvailable configurations:"
echo "$AVAILABLE_CONFIGS"

while true; do
    echo -n "Enter the target configuration name: "
    read -r TARGET_CONFIG

    if echo "$AVAILABLE_CONFIGS" | grep -qx "$TARGET_CONFIG"; then
        break
    else
        echo -e "\nInvalid configuration. Please enter a valid name."
        echo -e "Available options:\n$AVAILABLE_CONFIGS"
    fi
done

echo -n "Enter the username: "
read -r USER_NAME

echo -e "\nInstalling [$TARGET_CONFIG]..."
rm -rf "$NIXOS_DIR"
git clone --depth 1 "$GIT_REPO" "$NIXOS_DIR"
rm -rf "$NIXOS_DIR"/.git

sed -i "s/datlycan/$USER_NAME/g" "$NIXOS_DIR/settings.nix"

nixos-rebuild switch --flake /etc/nixos#"$TARGET_CONFIG" --show-trace