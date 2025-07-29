{ pkgs, ... }:
let
  my_emacs = {
    enable = true;
    package = pkgs.emacs-nox;
  };
in
{
  home.packages = with pkgs; [
    # -- [ General ] --
    binutils
    coreutils
    unzip
    clang-tools
    gnutls
    fd

    # -- [ Email ] --
    # mu
    # isync

    # --[ Org ] --
    # gnuplot
    zstd

    # -- [ Roam ] --
    sqlite

    # -- [ Treemacs ] --
    python314

    # -- [ Format ] --
    nodejs_20

    # Nix
    nixd
    nixfmt-rfc-style

    # Javascript
    biome
    typescript
    typescript-language-server
  ];

  programs.emacs = my_emacs;
  services.emacs = my_emacs;
}
