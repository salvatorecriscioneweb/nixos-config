{ pkgs, ... }:
{
  programs = {
    fish.enable = true;
    thunar.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;

      pinentryPackage = pkgs.pinentry-gnome3;
      settings = {
        default-cache-ttl = 1800;
      };
    };

    light.enable = true;
    seahorse.enable = true;

    adb.enable = true;

    nix-index-database = {
      comma.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    xfce.thunar-archive-plugin

    # Git
    git

    # Secure Boot
    sbctl
  ];
}
