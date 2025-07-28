{
  config,
  pkgs,
  lib,
  ...
}:
let
  terminal_client = "${pkgs.kitty}/bin/kitty";
  terminal = "${pkgs.kitty}/bin/kitty";
  file_manager = "${pkgs.xfce.thunar}/bin/thunar";
  launcher = "\"${pkgs.rofi-wayland}/bin/rofi -show drun\"";

  emacs_package = pkgs.emacs-pgtk;
in
{
  home.packages = with pkgs; [ swaybg ];

  wayland.windowManager.river = {
    enable = true;
    systemd = {
      enable = true;
      extraCommands = [
        # XDG
        "systemctl --user stop xdg-desktop-portal"
        "systemctl --user start xdg-desktop-portal"
        "systemctl --user restart pipewire"
        "systemctl --user restart kanshi"
        "systemctl --user restart swayidle"
        "systemctl --user restart app-com.cloudflare.WarpTaskbar@autostart.service"
        "systemctl --user restart waybar"
      ];
    };
    xwayland.enable = false;
    extraConfig = ''
      for i in $(seq 1 9)
      do
          tags=$((1 << ($i - 1)))

          # Super+[1-9] to focus tag [0-8]
          riverctl map normal Super $i set-focused-tags $tags

          # Super+Shift+[1-9] to tag focused view with tag [0-8]
          riverctl map normal Super+Shift $i set-view-tags $tags

          # Super+Control+[1-9] to toggle focus of tag [0-8]
          riverctl map normal Super+Control $i toggle-focused-tags $tags

          # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
          riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
      done

      for mode in normal locked
      do
        riverctl map $mode None XF86AudioMute spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'
        riverctl map $mode None XF86AudioMicMute spawn 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'
        riverctl map $mode None XF86AudioRaiseVolume spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+'
        riverctl map $mode None XF86AudioLowerVolume spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-'

        riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
        riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

        riverctl map $mode None XF86MonBrightnessUp   spawn 'light -A 5'
        riverctl map $mode None XF86MonBrightnessDown spawn 'light -U 5'
      done

      riverctl rule-add ssd

      # Make all views with an app-id that starts with "float" and title "foo" start floating.
      riverctl rule-add -app-id 'float*' -title 'foo' float

      # Make all views with app-id "bar" and any title use client-side decorations
      riverctl rule-add -app-id "bar" csd

      # Super + Left Mouse Button to move views
      riverctl map-pointer normal Super BTN_LEFT move-view

      # Super + Right Mouse Button to resize views
      riverctl map-pointer normal Super BTN_RIGHT resize-view

      # Super + Middle Mouse Button to toggle float
      riverctl map-pointer normal Super BTN_MIDDLE toggle-float

      # Set the default layout generator to be rivertile and start it.
      # River will send the process group of the init executable SIGTERM on exit.
      riverctl default-layout rivertile
      rivertile -view-padding 0 -outer-padding 0 -main-ratio 0.68 &
    '';
    settings = {
      border-width = 2;
      border-color-focused = lib.mkForce "0x${config.lib.stylix.colors.base08}";
      border-color-unfocused = lib.mkForce "0x${config.lib.stylix.colors.base06}";
      declare-mode = [
        "locked"
        "normal"
        "passthrough"
      ];
      input."\"*\"".tap = "enabled";
      focus-follows-cursor = "normal";
      set-cursor-warp = "on-focus-change";
      set-repeat = "50 300";
      map = {
        normal = {
          "Super" = {
            "L".send-layout-cmd.rivertile = "\"main-ratio -0.05\"";
            "H".send-layout-cmd.rivertile = "\"main-ratio +0.05\"";
            "Return".spawn = terminal_client;
            "F".spawn = "${file_manager}";
            "X".spawn = "${launcher}";
            "D".focus-view = "next";
            "A".focus-view = "previous";
            "Space" = "toggle-float";
            "P".spawn = "\"cliphist list | rofi -dmenu | cliphist decode | wl-copy\"";
            "Q" = "close";
          };
          "Super+Shift" = {
            "Return".spawn = terminal;
            "F" = "toggle-fullscreen";
            "E" = "${emacs_package}/bin/emacs";
            "L".spawn = "\"${pkgs.swaylock}/bin/swaylock --daemonize\"";
            "Q" = "exit";
            "R".spawn = "wl-capture-region";
            "J".swap = "next";
            "K".swap = "previous";
          };
        };
      };
      spawn = [
        "${pkgs.blueman}/bin/blueman-applet"
        "\"${pkgs.light}/bin/light -S 50\""
        "\"sleep 1 && ${pkgs.swaybg}/bin/swaybg -c 0089da\""
        "\"sleep 2 && ${pkgs.networkmanagerapplet}/bin/nm-applet\""
      ];
    };
  };
}
