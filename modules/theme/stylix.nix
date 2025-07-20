{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;

    targets = {
      chromium.enable = false;
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/one-light.yaml";
    # base16Scheme = ../../assets/base16-oxocarbon.yaml;

    # Fonts
    fonts =
      let
        p = pkgs.nerd-fonts.profont;
        p_norm = pkgs.inter;

        nmono = "ProFontWindows Nerd Font";
        nnorm = "Inter";
      in
      {
        serif = {
          package = p_norm;
          name = nnorm;
        };

        sansSerif = {
          package = p_norm;
          name = nnorm;
        };

        monospace = {
          package = p;
          name = nmono;
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          desktop = 12;
          applications = 12;
          terminal = 18;
        };
      };
  };
}
