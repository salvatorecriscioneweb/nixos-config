{ config, ... }:
{
  programs.direnv = {
    enable = true;
    silent = false; # It helps me understand when actually i am inside a env
    nix-direnv.enable = true;
  };
}
