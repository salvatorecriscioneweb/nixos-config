{
  nixpkgs,
  inputs,
}:
name:
{
  system,
  darwin ? false,
}:
let
  hostConfig = ../../host/${name};
  homeConfig = if darwin then ../../home-manager/darwin.nix else ../../home-manager/default.nix;

  systemFunc = if darwin then inputs.nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  home-manager =
    if darwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;

  isLinux = !darwin;
  user = if !darwin then "ssalva" else "salvatorecriscione";
in
systemFunc {
  inherit system;

  modules = [
    (if isLinux then inputs.lanzaboote.nixosModules.lanzaboote else { })
    (if isLinux then inputs.impermanence.nixosModules.impermanence else { })
    (if isLinux then inputs.agenix.nixosModules.default else { })
    (if isLinux then inputs.nix-index-database.nixosModules.nix-index else { })
    (if isLinux then inputs.stylix.nixosModules.stylix else inputs.stylix.darwinModules.stylix)
    (
      if isLinux then
        {
          nixpkgs.overlays = with inputs; [
            emacs-overlay.overlay
            niri-flake.overlays.niri
          ];

          environment.systemPackages = with inputs; [
            agenix.packages.${system}.default
            # chicago95-nix.packages.${system}.default
          ];

          imports = [
            ./secrets.nix
          ];

        }
      else
        { }
    )
    hostConfig
    home-manager.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        sharedModules =
          if isLinux then
            [
              inputs.niri-flake.homeModules.niri
            ]
          else
            [ ];
        users.${user} = import homeConfig;
      };
    }
    {
      config._module.args = {
        currentSystem = system;
        currentSystemName = name;
        currentSystemUser = user;
        inputs = inputs;
      };
    }
  ];
}
