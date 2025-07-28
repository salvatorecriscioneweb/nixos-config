{ pkgs, lib, ... }:
{
  programs = {
    fish.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };

    seahorse.enable = true;
    light.enable = true;

    adb.enable = true;

    nix-index-database = {
      comma.enable = true;
    };

    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xfce.thunar-archive-plugin
    xfce.catfish

    # Secure Boot
    sbctl
  ];
}
