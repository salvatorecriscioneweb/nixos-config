{ pkgs, ... }:
{
  hardware.graphics.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  programs.river = {
    enable = true;
    xwayland.enable = true;
    extraPackages = with pkgs; [
      swaybg
      tofi
      light
      gammastep
      emacs-pgtk
      nemo-with-extensions
    ];
  };

  # unlock keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd 'river' --greeting 'Bombay'";
        user = "ssalva";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
