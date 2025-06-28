{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = lib.mkDefault "luna";
    networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
      };
    };

    firewall = {
      enable = true;
    };
  };
}
