{ lib, ... }:
{
  powerManagement = {
    enable = true;
    powertop.enable = lib.mkDefault true;
  };

  services = {
    thermald.enable = lib.mkDefault true;
    power-profiles-daemon.enable = lib.mkDefault true;
    upower.enable = lib.mkDefault true;
  };
}
