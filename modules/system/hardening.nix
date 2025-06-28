{ lib, ... }:
{
  # Rip out everything by default
  environment.defaultPackages = lib.mkForce [ ];

  nix-mineral = {
    enable = true;
    overrides = {
      performance.allow-smt = true;
      desktop.tmp-exec = true;
      desktop.hideproc-off = true;
    };
  };

  # Breaks too much stuff
  # environment.memoryAllocator.provider = "scudo";
  services.dbus.apparmor = lib.mkDefault "enabled";

  security = {
    sudo = {
      execWheelOnly = true;
    };

    # Polkit
    polkit.enable = true;

    # RTKit
    rtkit.enable = true;

    # PAM
    pam = {
      services.swaylock = { };
      loginLimits = [
        {
          domain = "@users";
          item = "rtprio";
          type = "-";
          value = 1;
        }
      ];
      u2f.enable = true;
    };

  };

}
