{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;

    targets = {
      chromium.enable = false;
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal-khold.yaml";
    # base16Scheme = ../../assets/base16-oxocarbon.yaml;

    # Fonts
    fonts =
      let
        nmono = "LiterationMono Nerd Font";
        nnorm = "Inter";
      in
      {
        serif = {
          name = nnorm;
        };

        sansSerif = {
          name = nnorm;
        };

        monospace = {
          name = nmono;
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          desktop = 14;
          applications = 14;
          terminal = 16;
        };
      };
  };
}
