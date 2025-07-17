{ lib, pkgs, ... }:
{
  console = {
    earlySetup = true;
    font = "ter-v24b";
    keyMap = "us";
    packages = with pkgs; [ terminus_font ];
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.greetd}/bin/agreety --cmd river";
        };
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
