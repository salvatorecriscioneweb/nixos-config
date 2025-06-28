{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set SSH_ASKPASS ${pkgs.seahorse}/libexec/seahorse/ssh-askpass
    '';
    shellAbbrs = {
      cat = "bat";
      ls = "eza";
      update = "sudo nixos-rebuild switch";
      phx = "iex -S mix phx.server";
      ee = "emacs";
      keyboard_1 = "echo 1 > /sys/class/leds/tpacpi::kbd_backlight/brightness";
      keyboard_2 = "echo 2 > /sys/class/leds/tpacpi::kbd_backlight/brightness";
    };
  };
}
