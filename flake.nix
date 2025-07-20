{
  description = "Salvatore's NixOS Flake";

  inputs = {
    # --- [ Nix Packages ] ---
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # --- [ Home Manager ] ---
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- [ Secure Boot ] ---
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- [ Agenix Shhh ] ---
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- [ Distrohoping every reboot ] ---
    impermanence = {
      url = "github:nix-community/impermanence";
    };

    # --- [ Skill issues on setup 1to1 ] ---
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- [ Make stuff cool ] ---
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-25.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      mkSystem = import ./modules/utils/mkSystem.nix {
        inherit nixpkgs inputs;
      };
    in
    {
      nixosConfigurations = {
        luna = mkSystem "luna" {
          system = "x86_64-linux";
        };
      };
    };
}
