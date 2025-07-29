{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;

    targets = {
      chromium.enable = false;
      gtk.enable = false;
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    # Fonts
    fonts =
      let
        nmono = "UbuntuMono Nerd Font";
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
          desktop = 15;
          applications = 14;
          terminal = 18;
        };
      };
  };
}
