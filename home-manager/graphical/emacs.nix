{ pkgs, ... }:
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

    # -- [ Roam ] --
    sqlite

    # -- [ Treemacs ] --
    python314

    # -- [ Elixir ] ---
    lexical

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

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };
  services.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    defaultEditor = true;
  };
}
