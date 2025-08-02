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

      nixpkgs.overlays = with inputs; [
        emacs-overlay.overlay
        niri-flake.overlays.niri
      ];

      environment.systemPackages = with inputs; [
        agenix.packages.${system}.default
      ];

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
        sharedModules = [
          inputs.niri-flake.homeModules.niri
        ];
        users.ssalva = import homeConfig;
      };
    }
  ];
}
