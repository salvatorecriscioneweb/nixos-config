{ pkgs, lib, ... }:
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        shell = "${pkgs.fish}/bin/fish --login";
        workers = 14;
        pad = "10x10 center";
        line-height = 18;
      };
      scrollback = {
        lines = 10000;
      };
    };
  };
}
