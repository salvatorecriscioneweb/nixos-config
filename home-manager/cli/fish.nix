{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set SSH_ASKPASS ${pkgs.seahorse}/libexec/seahorse/ssh-askpass
      set SSH_ASKPASS_REQUIRE prefe
    '';
    shellAbbrs = {
      cat = "bat";
      ls = "eza";
      update = "sudo nixos-rebuild switch";
      phx = "iex -S mix phx.server";
      enable_net_vm = "virsh net-start default";
      ee = "emacsclient -c -nw";
      keyboard_1 = "echo 1 > /sys/class/leds/tpacpi::kbd_backlight/brightness";
      keyboard_2 = "echo 2 > /sys/class/leds/tpacpi::kbd_backlight/brightness";
    };
  };
}
