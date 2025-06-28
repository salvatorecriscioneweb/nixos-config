{ pkgs, lib, ... }:
{
  programs.foot = {
    enable = true;
    # server.enable = true;
    settings = {
      main = {
        shell = "${pkgs.fish}/bin/fish";
        workers = 14;
        pad = "10x10 center";
        line-height = 16;
      };
      # csd = {
      #   preferred = "none";
      # };
      colors = {
        alpha = lib.mkForce 0.98;
      };
      scrollback = {
        lines = 10000;
      };
    };
  };
}
