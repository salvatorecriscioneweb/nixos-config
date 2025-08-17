{
  pkgs,
  config,
  lib,
  ...
}:
let
  bg = "~/.config/wallpapers/linux-viola.svg";
in
{
  home.packages = with pkgs; [
    tofi
    gammastep
  ];

  home.file.".config/tofi" = {
    source = ../../assets/tofi;
    recursive = true;
  };

  wayland.windowManager.sway = {
    enable = true;

    config = {
      terminal = "${pkgs.kitty}/bin/kitty";
      bars = [ ];
      modifier = "Mod4";
      defaultWorkspace = "workspace number 1";
      gaps = {
        bottom = 4;
        left = 4;
        top = 4;
        right = 4;
        inner = 4;
      };
      startup = [
        {
          command = "${pkgs.swaybg}/bin/swaybg -i ${bg} &";
          always = true;
        }
        {
          command = "${pkgs.waybar}/bin/waybar &";
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
          command = "sleep 2 && /run/wrappers/bin/gnome-keyring-daemon --daemonize --start";
        }
        {
          always = true;
          command = "sleep 2 && systemctl --user restart pipewire";
        }
        {
          always = true;
          command = "sleep 2 && systemctl --user restart xdg-desktop-portal";
        }
        {
          always = true;
          command = "sleep 2 && systemctl --user restart kanshi";
        }
        {
          always = true;
          command = "sleep 2 && systemctl --user restart swayidle";
        }
        {
          always = true;
          command = "sleep 2 && systemctl --user restart app-com.cloudflare.WarpTaskbar@autostart.service";
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
          "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
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
          "${modifier}+Shift+e" = "exec ~/.config/scripts/tofi-power.sh";
          "${modifier}+q" = "kill";
          "${modifier}+e" = "exec ${pkgs.emacs-pgtk}/bin/emacs";
          "${modifier}+Shift+r" = "exec wl-capture-region";
          "${modifier}+Shift+l" = "exec ${pkgs.swaylock}/bin/swaylock --daemonize";
          "${modifier}+x" = "exec ${pkgs.tofi}/bin/tofi-drun";
        };
    };
  };
}
