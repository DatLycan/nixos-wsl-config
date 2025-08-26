{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fish
    fishPlugins.fzf-fish
    fzf
    neovim
    git
    eza
    bat
    zoxide
    jq
    wget
    lazygit
    lazydocker
  ];
}
