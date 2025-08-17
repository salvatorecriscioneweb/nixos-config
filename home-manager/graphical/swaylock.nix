let
  bg = "~/.config/wallpapers/linux-viola.svg";
in
{
  programs.swaylock = {
    enable = true;
    settings = {
      indicator-idle-visible = true;
      image = bg;
    };
  };
}
