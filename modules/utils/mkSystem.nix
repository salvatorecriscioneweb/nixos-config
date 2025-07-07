{
  nixpkgs,
  inputs,
}:
name:
{ system }:
let
  hostConfig = ../../host/${name};
  homeConfig = ../../home-manager/default.nix;
  systemFunc = nixpkgs.lib.nixosSystem;
in
systemFunc {
  inherit system;

  modules = [
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.impermanence.nixosModules.impermanence
    inputs.agenix.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
    inputs.stylix.nixosModules.stylix
    inputs.home-manager.nixosModules.home-manager
    {
      environment.systemPackages = with inputs; [
        agenix.packages.${system}.default
        needy-girl-overdose-theme-nix.packages.${system}.default
      ];

      # nixpkgs.overlays = with inputs; [ ];

      imports = [
        ./secrets.nix
      ];

    }
    hostConfig
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        # sharedModules = [ ];
        users.ssalva = import homeConfig;
      };
    }
  ];
}
