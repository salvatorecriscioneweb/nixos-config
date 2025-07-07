{ pkgs, ... }:
{
  fonts = {
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
      nerd-fonts.caskaydia-mono
    ];
  };
}
