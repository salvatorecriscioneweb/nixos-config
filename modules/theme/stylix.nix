{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;

    targets = {
      chromium.enable = false;
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";

    # Fonts
    fonts =
      let
        p = pkgs.nerd-fonts.caskaydia-mono;
        p_norm = pkgs.inter;

        nmono = "CaskaydiaMono Nerd Font";
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
          desktop = 11;
          applications = 11;
          terminal = 13;
        };
      };
  };
}
