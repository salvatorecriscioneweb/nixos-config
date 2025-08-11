{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config =
      let
        common = {
          default = [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
      in
      {
        inherit common;
        niri = common;
      };
    configPackages = [ pkgs.niri-stable ];
  };

  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  hardware.graphics.enable = true;

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-stable;

  services = {
    displayManager.defaultSession = "niri";
  };

  # unlock keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd niri-session --greeting 'welcome back'";
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
