{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  programs.river.enable = true;
  programs.river.xwayland.enable = false;

  programs.labwc.enable = true;
}
