{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./services
    ./cli
    ./graphical
    ./graphical/labwc.nix
    ./graphical/kanshi.nix
    ./dev
  ];

  home.packages = with pkgs; [
    # --- [ GTK Theme ] ---
    whitesur-gtk-theme

    # --- [ Generic ] ---
    chafa
    age
    wl-clipboard

    # --- [ Image Viewer ] ---
    xfce.ristretto

    xfce.xfce4-notifyd

    # Video Viewer
    # mpv
    # Audio Ctl
    playerctl

    # Figma
    # figma-linux

    # -- [ Graphics ] --
    gimp3

    # -- [ Music ] --
    spotify

    # -- [ Telegram ] --
    telegram-desktop
    zoom-us
    blanket

    # -- [ Office ] --
    libreoffice

    # -- [ Email ] --
    thunderbird

    # -- [ Slack ] --
    slack

    # (nerdfonts.override { fonts = ["Hack"]; })
  ];

  home.file = {
    ".config/wallpapers" = {
      source = ../assets/wallpapers;
      recursive = true;
    };
    ".config/doom/config.org" = {
      source = ../assets/doom.org;
    };
  };

  programs.home-manager.enable = true;

  home = {
    pointerCursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 32;
      x11.enable = true;
      gtk.enable = true;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Light";
    };
    iconTheme = {
      name = "Haiku";
    };
  };

  home.sessionVariables = {
    NH_FLAKE = "/home/ssalva/dev/personal/nixos-config"; # Flake for NH
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = 1;
    MOZ_ENABLE_WAYLAND = 1;
    ELECTRON_OZONE_PLATFORM_HINT = 1;
    DO_NOT_TRACK = 1;
  };

  stylix.targets = {
    vencord.enable = false;
    blender.enable = false;
    qutebrowser.enable = false;
    emacs.enable = false;
    kde.enable = false;
    qt.enable = false;
    gtk.enable = false;
    waybar.enable = false;
    tofi.enable = false;
    rofi.enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      let
        default_browser = "google-chrome.desktop";
        default_terminal = "kitty.desktop";
        default_image_viewer = "ristretto.desktop";
      in
      {
        "text/html" = default_browser;
        "x-scheme-handler/http" = default_browser;
        "x-scheme-handler/https" = default_browser;
        "x-scheme-handler/about" = default_browser;
        "x-scheme-handler/unknown" = default_browser;
        "x-scheme-handler/terminal" = lib.mkDefault default_terminal;
        "image/png" = default_image_viewer;
        "image/jpeg" = default_image_viewer;
        "image/jpg" = default_image_viewer;
        "image/webp" = default_image_viewer;
        "image/gif" = default_image_viewer;
      };
  };

  xdg.configFile."gtk-3.0/bookmarks".text =
    let
      home = config.home.homeDirectory;
    in
    ''
      file://${home}/dev
      file://${home}/dev/personal
      file://${home}/Notes
      file://${home}/Downloads
      file://${home}/Documents
      file://${home}/Pictures
    '';

  home.stateVersion = "24.11"; # Please read the comment before changing.
}
