{ pkgs, ... }:
{
  # Allow Unfree
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.latest;
    optimise.automatic = true;

    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };

    # disable usage of nix channels
    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    extraOptions = ''
      # Ensure we can still build when a binary cache is not accessible
      fallback = true
    '';

  };
  # Sometimes it fails if a store path is still in use.
  systemd.services.nix-gc.serviceConfig = {
    Restart = "on-failure";
  };
}
