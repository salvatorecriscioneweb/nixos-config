{ lib, pkgs, ... }:
{
  console = {
    earlySetup = true;
    font = "ter-v24b";
    keyMap = "us";
    packages = with pkgs; [ terminus_font ];
  };

  services = {
    displayManager.ly = {
      enable = true;
      x11Support = false;
      settings = {
        animation = "colormix";
        blank_password = true;
        brightness_down_cmd = "${pkgs.light}/bin/light -U 10";
        brightness_up_cmd = "${pkgs.light}/bin/light -A 10";
        # Color mixing animation first color id
        colormix_col1 = "0x00FF0000";

        # Color mixing animation second color id
        colormix_col2 = "0x000000FF";

        # Color mixing animation third color id
        colormix_col3 = "0x20000000";
      };
    };
  };

  boot = {
    loader = {
      timeout = 0;
      systemd-boot.enable = lib.mkForce false;
      # systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    # plymouth = {
    # enable = true;
    # };

    # Secure Boot
    lanzaboote = {
      enable = lib.mkForce true;
      pkiBundle = "/var/lib/sbctl";
    };

    kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
    };
  };
}
