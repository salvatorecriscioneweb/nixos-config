{ lib, ... }:
{
  powerManagement = {
    enable = true;
    powertop.enable = lib.mkDefault true;
  };
  services = {
    thermald.enable = lib.mkDefault true;
    power-profiles-daemon.enable = lib.mkDefault false;
    tlp = {
      enable = lib.mkDefault true;
      settings = {
        USB_EXCLUDE_PRINTER = 0;

        # CPU Boost
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        # CPU HWP (Hardware P-States)
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        USB_AUTOSUSPEND = 0;
        START_CHARGE_THRESH_BAT0 = 70;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}
