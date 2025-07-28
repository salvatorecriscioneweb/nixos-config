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
        "systemctl --user restart foot-server"
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
          command = "${pkgs.swaybg}/bin/swaybg -c 0089da";
          always = true;
        }
      ];
      bars = [ ];
      modifier = "Mod4";
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${pkgs.foot}/bin/footclient";
          "${modifier}+Shift+Return" = "exec ${pkgs.foot}/bin/foot";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
          "XF86AudioMedia" = "exec playerctl play-pause";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioNext" = "exec playerctl next";
          "XF86_MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 10";
          "XF86_MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 10";
          "${modifier}+q" = "kill";
          "${modifier}+r" = "exec wl-capture-region";
          "${modifier}+e" = "exec emacs";
          "${modifier}+Shift+l" = "exec ${pkgs.swaylock}/bin/swaylock --daemonize";
          "${modifier}+x" = "exec ${pkgs.rofi-wayland}/bin/rofi -show drun";
        };

    };
  };
}
