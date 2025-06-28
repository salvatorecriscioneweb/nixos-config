{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;

    targets = {
      qt.enable = false;
      chromium.enable = false;
      gtk.enable = lib.mkDefault false;
    };

    base16Scheme = ../../assets/base16-oxocarbon.yaml;

    # Fonts
    fonts =
      let
        p = pkgs.nerd-fonts.atkynson-mono;
        p_norm = pkgs.ibm-plex;

        nmono = "AtkynsonMono Nerd Font";
        nnorm = "IBM Plex Serif";
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
          terminal = 13;
        };
      };
  };
}
