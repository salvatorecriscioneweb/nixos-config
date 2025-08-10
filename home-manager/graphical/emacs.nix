{ pkgs, ... }:
let
  my_emacs = {
    enable = true;
    package = pkgs.emacs-unstable-pgtk;
  };
in
{
  home.packages = with pkgs; [
    # -- [ General ] --
    binutils
    coreutils
    unzip
    gcc # Treesitter
    clang-tools
    gnutls
    fd

    (aspellWithDicts (
      ds: with ds; [
        en
        en-computers
        en-science
      ]
    ))

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
}
