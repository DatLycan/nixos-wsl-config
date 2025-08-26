{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnumake
    jdk11
    nodejs_22
    dotnet-sdk
  ];
}
