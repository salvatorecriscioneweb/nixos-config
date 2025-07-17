{ pkgs, lib, ... }:
{
  programs = {
    fish.enable = true;
    thunar.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;

      settings = {
        default-cache-ttl = 60;
        max-cache-ttl = 120;
      };
    };

    seahorse.enable = true;

    light.enable = true;

    adb.enable = true;

    nix-index-database = {
      comma.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    killall

    xfce.thunar-archive-plugin
    xfce.catfish

    # Git
    git

    # Secure Boot
    sbctl
  ];
}
