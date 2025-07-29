{ pkgs, lib, ... }:
{
  programs = {
    fish.enable = true;

    seahorse.enable = true;

    light.enable = true;

    adb.enable = true;

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
