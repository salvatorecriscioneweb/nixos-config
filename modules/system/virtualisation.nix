{ pkgs, lib, ... }:
{
  virtualisation.containers.enable = true;
  virtualisation.docker.enable = true;

  security.virtualisation.flushL1DataCache = lib.mkDefault "always";

  programs.virt-manager.enable = true;

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
