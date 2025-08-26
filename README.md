## Quick Start
1. Install [NixOS-WSL](https://github.com/nix-community/NixOS-WSL)
2. Run:

```bash
sudo nix-shell -p git jq --run "curl -L https://raw.githubusercontent.com/DatLycan/nixos-wsl-config/stable/install.sh | sudo sh -s -- <username> <target_config>"
```

* `<username>`: This is the name for the new user account that will be created on your NixOS system.
* `<target_config>`: This is the name of the NixOS configuration you want to install. You can find a list of available configurations by looking at the [flake.nix](./flake.nix) file.