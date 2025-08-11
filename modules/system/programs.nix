{ pkgs, lib, ... }:
{
  programs = {
    fish.enable = true;

    seahorse.enable = true;

    light.enable = true;

    adb.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      #pinentryFlavor = "gtk2"; ## 2024-06-01: not available with NixOS 24.05 any more
      pinentryPackage = pkgs.pinentry-gtk2;
    };

    nix-index-database = {
      comma.enable = true;
    };

    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Secure Boot
    sbctl
    # File Manager
    nautilus
  ];
}
