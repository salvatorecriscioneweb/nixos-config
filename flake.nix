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
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.home-manager.follows = "home-manager";
    };

    # --- [ System Hardening ] ---
    # Removed as breaks the root wipe FS
    # TODO: Check if i can fix it
    # nix-mineral = {
    #   url = "github:cynicsketch/nix-mineral"; # Refers to a specific commit and follows that until you change it
    #   flake = false;
    # };
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

        # TODO: Finalize this
        luna-vm = mkSystem "luna" {
          system = "x86_64-linux";
        };
      };
    };
}
