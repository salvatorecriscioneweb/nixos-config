{ pkgs, lib, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "${pkgs.fish}/bin/fish --login";
        workers = 14;
        pad = "24x24 center";
        line-height = 20;
      };
      scrollback = {
        lines = 10000;
      };
    };
  };
}
