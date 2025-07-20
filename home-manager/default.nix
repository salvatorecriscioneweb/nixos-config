{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    # --- [ Services ] ---
    ./services/kanshi.nix
    ./services/swayidle.nix
    ./services/mako.nix

    # --- [ CLI ] ---
    ./cli/git.nix
    ./cli/gh.nix
    ./cli/fish.nix
    ./cli/starship.nix
    ./cli/helix.nix
    ./cli/gpg.nix
    ./cli/screenshot.nix
    ./cli/fastfetch.nix
    ./cli/ripgrep.nix
    ./cli/fd.nix
    ./cli/direnv.nix
    ./cli/eza.nix
    ./cli/bat.nix
    ./cli/lazygit.nix
    ./cli/nh.nix
    ./cli/tmux.nix

    # --- [ DE ] ---
    ./graphical/river.nix

    # --- [ Graphical ] ---
    ./graphical/foot.nix
    ./graphical/emacs.nix
    ./graphical/rofi.nix
    ./graphical/waybar.nix
    ./graphical/swaylock.nix
    ./graphical/browsers.nix
    ./graphical/zathura.nix
    # ./graphical/kitty.nix
  ];

  home.packages = with pkgs; [
    chafa
    age
    wl-clipboard
    # Image Viewer
    imv
    # Video Viewer
    mpv
    # Audio Ctl
    playerctl

    # -- [ VMs ] --
    #  gnome-boxes

    # -- [ Graphics ] --
    gimp3

    # -- [ Music ] --
    spotify

    # -- [ Telegram ] --
    telegram-desktop
    zoom-us

    # -- [ Office ] --
    libreoffice

    # -- [ Email ] --
    thunderbird

    # -- [ Slack ] --
    slack

    htop
  ];

  home.file = {
    ".config/doom/config.org" = {
      source = ../assets/doom.org;
    };
    ".config/wallpapers" = {
      source = ../assets/wallpapers;
      recursive = true;
    };
  };

  programs.home-manager.enable = true;

  home = {
    pointerCursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 32;
      x11.enable = false;
      gtk.enable = true;
    };
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Vimix-White";
      package = pkgs.vimix-icon-theme;
    };
  };

  stylix.targets = {
    vencord.enable = false;
    blender.enable = false;
    tmux.enable = false;
    qutebrowser.enable = false;
    emacs.enable = false;
    waybar.enable = false;
    kde.enable = false;
    qt.enable = false;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      let
        default_browser = "google-chrome.desktop";
        default_terminal = "footclient.desktop";
        default_image_viewer = "imv.desktop";
        default_document_viewer = "zathura.desktop";
      in
      {
        "text/html" = default_browser;
        "x-scheme-handler/http" = default_browser;
        "x-scheme-handler/https" = default_browser;
        "x-scheme-handler/about" = default_browser;
        "x-scheme-handler/unknown" = default_browser;
        "x-scheme-handler/terminal" = lib.mkDefault default_terminal;
        "application/pdf" = default_document_viewer;
        "image/png" = default_image_viewer;
        "image/jpeg" = default_image_viewer;
      };
  };

  xdg.configFile."gtk-3.0/bookmarks".text =
    let
      home = config.home.homeDirectory;
    in
    ''
      file://${home}/dev
      file://${home}/Notes
      file://${home}/Downloads
      file://${home}/Documents
      file://${home}/Pictures
    '';

  home.stateVersion = "24.11"; # Please read the comment before changing.
}
