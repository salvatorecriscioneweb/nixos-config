{
  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";

  environment = {
    sessionVariables = {
      NH_FLAKE = "/home/ssalva/dev/personal/nixos-config"; # Flake for NH
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = 1;
      MOZ_ENABLE_WAYLAND = 1;
      ELECTRON_OZONE_PLATFORM_HINT = 1;
    };

    variables = {
      EDITOR = "emacs -nw"; # Set default EDITOR
      PATH = [ "/persist/home/ssalva/.config/emacs/bin" ];
    };

    "etc"."nixos".source = "/persist/home/ssalva/dev/personal/nixos-config";
  };
}
