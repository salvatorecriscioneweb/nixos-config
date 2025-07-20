{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs = {
    starship = {
      enable = true;

      enableZshIntegration = config.programs.zsh.enable;
      enableFishIntegration = config.programs.fish.enable;
    };
  };
}
