{ pkgs, ... }:
{
  imports = [
    ./cli/fish.nix
    ./cli/bat.nix
    ./cli/helix.nix
    ./cli/eza.nix
    ./cli/ripgrep.nix
    ./cli/starship.nix
    ./cli/git.nix
    ./cli/gh.nix

    ./graphical/kitty.nix
  ];

  stylix.targets = {
    kitty.enable = true;
    helix.enable = true;
    bat.enable = true;
    fish.enable = true;
  };

  home.packages = with pkgs; [
    htop
  ];

  home.file = {
    ".config/doom/config.org" = {
      source = ../assets/doom.org;
    };
    ".config/wallpapers" = {
      source = ../assets/wallpapers;
      recursive = true;
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11"; # Please read the comment before changing.
}
