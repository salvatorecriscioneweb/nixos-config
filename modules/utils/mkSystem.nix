{
  nixpkgs,
  inputs,
}:
name:
{ system }:
let
  hostConfig = ../../host/${name};
  # TODO: In the future make more configurable
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
    # inputs.microvm.nixosModules.host
    {
      environment.systemPackages = [
        inputs.agenix.packages.${system}.default
        inputs.needy-girl-overdose-theme-nix.packages.${system}.default
      ];

      nixpkgs.overlays = with inputs; [
        emacs-overlay.overlay
      ];

      imports = [
        "${inputs.nix-mineral}/nix-mineral.nix"
        ./secrets.nix
      ];

    }
    # My Host Config imported previously
    hostConfig
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        sharedModules = [ ];
        users.ssalva = import homeConfig;
      };
    }
  ];
}
