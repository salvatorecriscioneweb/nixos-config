{ lib, pkgs, ... }:
{
  console = {
    earlySetup = true;
    font = "ter-v24b";
    keyMap = "us";
    packages = with pkgs; [ terminus_font ];
  };

  zramSwap.enable = lib.mkDefault true;

  boot = {
    # initrd.systemd.enable = true;
    loader = {
      timeout = 0;
      systemd-boot = {
        enable = lib.mkForce false;
        configurationLimit = 15; # prevent "too many" configuration from showing up on the boot menu
      };

      # systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

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

    kernelParams = [
      # allow systemd to set and save the backlight state
      "acpi_backlight=native"
    ];
  };
}
