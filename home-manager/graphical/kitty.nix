{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    shellIntegration = {
      enableZshIntegration = config.programs.zsh.enable;
      enableFishIntegration = config.programs.fish.enable;
    };

    settings = {
      shell = "${pkgs.fish}/bin/fish --login";
      tab_bar_edge = "top";
      window_padding_width = 12;
      cursor_trail = 3;
      tab_bar_align = "center";
      hide_window_decorations = "yes";
    };

    keybindings = {
      "opt+t" = "new_tab";
      "opt+s" = "new_window";
      "opt+z" = "next_layout";
      "opt+w" = "close_tab";
      "opt+1" = "goto_tab 1";
      "opt+2" = "goto_tab 2";
      "opt+3" = "goto_tab 3";
      "opt+4" = "goto_tab 4";
      "opt+5" = "goto_tab 5";
      "opt+6" = "goto_tab 6";
    };
  };
}
