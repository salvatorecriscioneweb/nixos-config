{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chromium
    brave
    google-chrome
    firefox
  ];
}
