{
  pkgs,
  config,
  lib,
  ...
}:
{
  wayland.windowManager.sway = {
    enable = true;
    systemd = {
      enable = true;
      extraCommands = [
        "systemctl --user restart emacs"
        "systemctl --user restart xdg-desktop-portal"
        "systemctl --user restart pipewire"
        "systemctl --user restart kanshi"
        "systemctl --user restart swayidle"
        "systemctl --user restart app-com.cloudflare.WarpTaskbar@autostart.service"
      ];
    };
    config = {
      terminal = "${pkgs.foot}/bin/footclient";
      startup = [
        {
          command = "systemctl --user restart waybar";
          always = true;
        }
        {
          command = "systemctl --user restart foot-server";
          always = true;
        }
        {
          command = "${pkgs.swaybg}/bin/swaybg -i ~/.config/wallpapers/wallhaven-45kjv5.jpg";
          always = true;
        }
        {
          command = "${pkgs.xfce.xfce4-panel}/bin/xfce4-panel";
        }
      ];
      bars = [ ];
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${pkgs.foot}/bin/footclient";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "${modifier}+q" = "kill";
          "${modifier}+r" = "exec wl-capture-region";
          "${modifier}+Shift+l" = "exec ${pkgs.swaylock}/bin/swaylock --daemonize";
          "${modifier}+x" = "exec ${pkgs.rofi-wayland}/bin/rofi -show drun";
        };

    };
  };
}
