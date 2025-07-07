{
  environment.persistence."/persist" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/sbctl"
      "/var/lib/fprint"
      "/var/lib/cloudflare-warp"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];

    users.ssalva = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "Notes"
        "dev"

        # Hidden
        ".mix"
        ".hex"
        ".gnupg"
        ".ssh"
        ".tmux"

        # Locals
        ".local/share/warp"
        ".local/share/kwalletd"
        ".local/share/direnv"

        # Thunderbird
        ".cache/thunderbird"

        # Config
        ".config"
        ".local/share/doom"
      ];
      files = [
        ".config/gh/hosts.yml"
      ];
    };
  };
}
