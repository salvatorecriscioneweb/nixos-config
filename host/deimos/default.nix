{ pkgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 6;

  nixpkgs.hostPlatform = "x86_64-darwin";

  programs.zsh.enable = true;
  programs.zsh.shellInit = ''
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
  '';

  programs.fish.enable = true;
  programs.fish.shellInit = ''
    # Nix
    if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    end
    # End Nix
  '';

  environment.shells = with pkgs; [
    bashInteractive
    zsh
    fish
  ];

  homebrew = {
    enable = true;
    taps = [ "d12frosted/emacs-plus" ];
    casks = [ ];
    brews = [ "emacs-plus" ];
  };

  users.users.salvatorecriscione = {
    name = "salvatorecriscione";
    home = "/Users/salvatorecriscione";
  };

  # Required for some settings like homebrew to know what user to apply to.
  system.primaryUser = "salvatorecriscione";

  security.pam.services.sudo_local.touchIdAuth = true;

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    neovim

    inter

    # -- [ Emacs ] --
    nerd-fonts.symbols-only

    # -- [ Nerd Fonts ] --
    nerd-fonts.recursive-mono
    nerd-fonts.monoid
  ];

  stylix = {
    enable = true;
    autoEnable = false;

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";

    fonts =
      let
        nmono = "RecMonoDuotone Nerd Font";
        nnorm = "Inter";
      in
      {
        serif = {
          name = nnorm;
        };

        sansSerif = {
          name = nnorm;
        };

        monospace = {
          name = nmono;
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          desktop = 13;
          applications = 13;
          terminal = 14;
        };
      };
  };
}
