{
  lib,
  pkgs,
  config,
  ...
}:
{
  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  services = {
    speechd.enable = lib.mkForce false;
    journald = {
      storage = "volatile"; # Store logs in memory
      upload.enable = false; # Disable remote log upload (the default)
      extraConfig = lib.mkDefault "SystemMaxUse=2G";
    };

    printing.enable = lib.mkForce false;

    locate.enable = true;

    blueman.enable = lib.mkDefault true;

    udev.enable = true;

    fstrim.enable = lib.mkDefault true;

    # --- [ Touchpad ] ---
    libinput.enable = lib.mkDefault true;

    # --- [ Storages ] ---
    udisks2.enable = lib.mkDefault true;

    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images

    # --- [ Gnome Keyring ] ---
    gnome.gnome-keyring.enable = true;

    # --- [ Cloudflare Warp ] ---
    cloudflare-warp.enable = lib.mkDefault true;

    # --- [ Pipewire ] ---
    pipewire = {
      enable = true; # if not already enabled
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    # --- [ Firmware Update ] ---
    fwupd.enable = true;

    # --- [ Yubikey ] ---
    pcscd.enable = lib.mkDefault true;
    udev.packages = lib.mkIf config.services.pcscd.enable [ pkgs.yubikey-personalization ];

    dbus = {
      enable = true;
      implementation = "broker";
    };

    btrfs.autoScrub.enable = true;
  };

  systemd.services = {
    NetworkManager-wait-online.enable = false;
  };
}
