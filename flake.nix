{
  description = "Salvatore's NixOS Flake";

  inputs = {
    # --- [ Nix Packages ] ---
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # --- [ Home Manager ] ---
    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- [ Secure Boot ] ---
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- [ Agenix ] ---
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- [ Distro-hoping every reboot ] ---
    impermanence = {
      url = "github:nix-community/impermanence";
    };

    # --- [ Skill issue on setup 1to1 ] ---
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- [ Make cool stuff ] ---
    stylix = {
      # url = "github:nix-community/stylix";
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- [ MacOS ] ---
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- [ Old school ] ---
    # chicago95-nix = {
    #   url = "github:salvatorecriscioneweb/chicago95-nix";
    # };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      self,
      ...
    }@inputs:
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
      darwinConfigurations = {
        "Salvatores-MacBook-Pro" = mkSystem "deimos" {
          system = "x86_64-darwin";
          darwin = true;
        };
      };
    };
}
