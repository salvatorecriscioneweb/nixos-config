{ lib, ... }:
{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    thermald.enable = lib.mkDefault true;

    power-profiles-daemon.enable = lib.mkDefault true;
  };
}
