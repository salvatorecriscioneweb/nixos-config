{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    xfce.thunar
  ];

  wayland.windowManager.sway = {
    enable = true;
    systemd = {
      enable = true;
      extraCommands = [
        "systemctl --user restart pipewire"
        "systemctl --user restart xdg-desktop-portal"
        "systemctl --user restart kanshi"
        "systemctl --user restart swayidle"
        "systemctl --user restart app-com.cloudflare.WarpTaskbar@autostart.service"
      ];
    };

    config = {
      terminal = "${pkgs.foot}/bin/footclient";
      bars = [ ];
      modifier = "Mod4";
      defaultWorkspace = "workspace number 1";
      startup = [
        {
          command = "${pkgs.swaybg}/bin/swaybg -i ~/.config/wallpapers/fly_me_to_the_moon.jpg &";
          always = true;
        }
        {
          command = "${pkgs.waybar}/bin/waybar &";
          always = true;
        }
        {
          command = "${pkgs.networkmanagerapplet}/bin/nm-applet &";
          always = true;
        }
        {
          command = "${pkgs.light}/bin/light -S 50";
        }
        {
          command = "${pkgs.blueman}/bin/blueman-applet &";
        }
        {
          command = "sleep 2 && ${pkgs.foot}/bin/foot --server &";
        }
        {
          command = "sleep 2 && /run/wrappers/bin/gnome-keyring-daemon --daemonize --start";
        }
      ];
      input = {
        "*" = {
          tap = "enabled";
        };
      };
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
          "XF86_MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5";
          "XF86_MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 5";
          "${modifier}+q" = "kill";
          "${modifier}+Shift+r" = "exec wl-capture-region";
          "${modifier}+Shift+l" = "exec ${pkgs.swaylock}/bin/swaylock --daemonize";
          "${modifier}+x" = "exec ${pkgs.rofi-wayland}/bin/rofi -show drun";
        };
    };
  };

}
