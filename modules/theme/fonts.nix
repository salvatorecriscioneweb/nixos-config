{ pkgs, ... }:
{
  fonts = {
    fontconfig = {
      enable = true;
      hinting.enable = true;
      antialias = true;
    };

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    packages = with pkgs; [
      noto-fonts-emoji
      inter

      # -- [ Emacs ] --
      nerd-fonts.symbols-only

      # -- [ Nerd Fonts ] --
      nerd-fonts.recursive-mono
      nerd-fonts.monoid
    ];
  };
}
