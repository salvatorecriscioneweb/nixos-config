{ pkgs, lib, ... }:
{
  programs = {
    fish.enable = true;

    seahorse.enable = true;

    light.enable = true;

    adb.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };

    nix-index-database = {
      comma.enable = true;
    };

    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Secure Boot
    sbctl
  ];
}
