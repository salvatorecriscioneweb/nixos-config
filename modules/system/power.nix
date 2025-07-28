{ lib, ... }:
{
  powerManagement = {
    enable = true;
  };

  services = {
    thermald.enable = lib.mkDefault true;
    tlp = {
      enable = true;
      settings = {
        USB_EXCLUDE_PRINTER = 0;
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        USB_AUTOSUSPEND = 0;
        START_CHARGE_THRESH_BAT0 = 70;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}
