{ settings, pkgs, ... }:
{
  imports = [
    ./base-packages.nix
    ./docker.nix
  ];

  system.stateVersion = "${settings.version}";

  wsl.enable = true;
  wsl.defaultUser = "${settings.username}";
  wsl.useWindowsDriver = true;

  programs.nh.enable = true;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit settings;
    };
    users.${settings.username} = import ./user.nix;
    backupFileExtension = "backup";
  };
}
