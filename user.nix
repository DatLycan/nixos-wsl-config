{ settings, ... }:
{
  imports = [
    ./fish.nix
  ];

  home.stateVersion = "${settings.version}";
  home.enableNixpkgsReleaseCheck = false;
  programs.home-manager.enable = true;
}