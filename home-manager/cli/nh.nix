{ config, ... }:
{
  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 5d --keep 5";
      flake = "${config.home.homeDirectory}/dev/personal/nixos-config";
    };
  };
}
