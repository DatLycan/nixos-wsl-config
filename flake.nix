{
  description = "NixOS for WSL";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    settings = import ./settings.nix;
  in {
    nixosConfigurations = {
      wsl-minimal = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
          inherit settings;
        };
        system = "${system}";
        modules = [
          { networking.hostName = "wsl-minimal"; }
          ./system.nix
          inputs.nixos-wsl.nixosModules.default
          inputs.home-manager.nixosModules.default
        ];
      };

      wsl-work = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
          inherit settings;
        };
        system = "${system}";
        modules = [
          { networking.hostName = "wsl-work"; }
          ./system.nix
          ./work-packages.nix
          inputs.nixos-wsl.nixosModules.default
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}