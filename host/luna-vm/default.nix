{ lib, ... }:
{
  # TODO: Finalize this VM Test
  imports = [
    ../../modules
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
