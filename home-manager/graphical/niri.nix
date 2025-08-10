{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs = {
    niri = {
      enable = true;
      package = pkgs.niri;
      settings = {
        animations.enable = true;
        outputs = {
          "eDP-1" = {
            scale = 1.25;
          };
          "DP-5" = {
            scale = 1.75;
          };
          "DP-6" = {
            scale = 1.75;
          };

        };
        hotkey-overlay.skip-at-startup = true;
        cursor.hide-when-typing = true;
        window-rules = [
          {
            clip-to-geometry = true;
            geometry-corner-radius =
              let
                r = 12.0;
              in
              {
                bottom-left = r;
                bottom-right = r;
                top-left = r;
                top-right = r;
              };
          }
        ];
        layout =
          let
            distance = 0;
          in
          {
            always-center-single-column = true;
            # center-focused-column = "always";
            struts = {
              left = distance;
              bottom = distance;
              top = distance;
              right = distance;
            };
            shadow = {
              enable = false;
            };
            gaps = 24;
            border =
              let
                bg = config.lib.stylix.colors.base06;
                bg_active = config.lib.stylix.colors.base08;
                width = 4;
              in
              {
                enable = true;
                width = width;
                active = {
                  color = bg_active;
                };
                inactive = {
                  color = bg;
                };
              };
            focus-ring = {
              enable = false;
            };
          };
        input.focus-follows-mouse.enable = true;
        spawn-at-startup = [
          {
            command = [ "${pkgs.blueman}/bin/blueman-applet" ];
          }
          {
            command = [
              (lib.getExe pkgs.swaybg)
              #"-c"
              #"000000"
              "-i"
              "${../../assets/wallpapers/wallhaven-vpgo1m.jpg}"
            ];
          }
          {
            command = [
              (lib.getExe pkgs.light)
              "-S"
              "50"
            ];
          }
          {
            command = [ (lib.getExe pkgs.xwayland-satellite) ];
          }
          {
            command = [
              "systemctl"
              "restart"
              "--user"
              "waybar"
            ];
          }
          {
            command = [ "${pkgs.networkmanagerapplet}/bin/nm-applet" ];
          }
        ];
        binds = {
          "XF86AudioMute".action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
          "XF86AudioMicMute".action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
          "XF86AudioRaiseVolume".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1+"
          ];
          "XF86AudioLowerVolume".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1-"
          ];
          "XF86MonBrightnessDown".action.spawn = [
            "light"
            "-U"
            "5"
          ];
          "XF86MonBrightnessUp".action.spawn = [
            "light"
            "-A"
            "5"
          ];
          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+Ctrl+Left".action = config.lib.niri.actions.move-column-left;
          "Mod+Ctrl+Down".action = config.lib.niri.actions.move-window-down;
          "Mod+Ctrl+Up".action = config.lib.niri.actions.move-window-up;
          "Mod+Ctrl+Right".action = config.lib.niri.actions.move-column-right;
          "Mod+Ctrl+H".action = config.lib.niri.actions.move-column-left;
          "Mod+Ctrl+J".action = config.lib.niri.actions.move-window-down;
          "Mod+Ctrl+K".action = config.lib.niri.actions.move-window-up;
          "Mod+Ctrl+L".action = config.lib.niri.actions.move-column-right;
          "Mod+Minus".action = config.lib.niri.actions.set-column-width "-5%";
          "Mod+Equal".action = config.lib.niri.actions.set-column-width "+5%";
          "Mod+W".action = config.lib.niri.actions.toggle-overview;
          "Mod+Shift+4".action.spawn = [
            "sh"
            "-c"
            "wl-capture-region"
          ];
          "Mod+Left".action = config.lib.niri.actions.focus-column-left;
          "Mod+A".action = config.lib.niri.actions.focus-column-left;
          "Mod+D".action = config.lib.niri.actions.focus-column-right;
          "Mod+Down".action = config.lib.niri.actions.focus-window-down;
          "Mod+Up".action = config.lib.niri.actions.focus-window-up;
          "Mod+Right".action = config.lib.niri.actions.focus-column-right;
          "Mod+F".action = config.lib.niri.actions.maximize-column;
          "Mod+Shift+F".action = config.lib.niri.actions.fullscreen-window;
          "Mod+V".action = config.lib.niri.actions.toggle-window-floating;
          "Mod+C".action = config.lib.niri.actions.center-column;
          "Mod+Q".action = config.lib.niri.actions.close-window;
          "Mod+Return".action.spawn = [
            "${pkgs.kitty}/bin/kitty"
          ];
          "Mod+E".action.spawn = [
            "${pkgs.emacs-unstable-pgtk}/bin/emacs"
          ];
          "Mod+X".action.spawn = [
            (lib.getExe pkgs.rofi-wayland)
            "-show"
            "drun"
          ];
          "Mod+Tab".action.spawn = [
            (lib.getExe pkgs.rofi-wayland)
            "-show"
            "window"
          ];
          "Mod+Shift+L".action.spawn = [
            (lib.getExe pkgs.swaylock)
            "--daemonize"
          ];
          "Mod+Ctrl+Shift+E".action.quit.skip-confirmation = true;
        };
      };
    };
  };

  home.packages = with pkgs; [
    desktop-file-utils
    networkmanagerapplet
    swayidle
    grim
    slurp
    swaybg
    xwayland-satellite
  ];

}
