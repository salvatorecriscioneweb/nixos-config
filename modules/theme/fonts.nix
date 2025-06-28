{ pkgs, ... }:
{
  fonts = {
    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    packages = with pkgs; [
      noto-fonts-emoji
      ibm-plex

      # -- [ Emacs ] --
      nerd-fonts.symbols-only

      # -- [ Nerd Fonts ] --
      nerd-fonts.liberation
      nerd-fonts.victor-mono
    ];
  };
}
