{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./disk.nix
    ../../modules
    ../../modules/theme
  ];

  # environment.systemPackages = [
  #   pkgs.qemu
  # ];
  # virtualisation.libvirtd.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "24.11"; # Did you read the comment?
}
