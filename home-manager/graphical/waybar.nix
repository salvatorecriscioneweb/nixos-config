{ pkgs, ... }:
{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
  };

  home.file = {
    ".config/scripts" = {
      recursive = true;
      source = ../../assets/scripts;
    };
    ".config/waybar" = {
      source = ../../assets/waybar;
      recursive = true;
    };
  };
}
