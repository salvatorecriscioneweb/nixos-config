{
  pkgs,
  ...
}:
{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = (60 * 2); # 2 Minutes
        command = "${pkgs.light}/bin/light -S 20";
      }
      {
        timeout = (60 * 5) - 10; # 4 Minutes 50 seconds
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds' -t 5000";
      }
      {
        timeout = (60 * 5); # 5 Minutes
        command = "${pkgs.swaylock}/bin/swaylock --daemonize -c ~/.config/swaylock/config";
      }
      {
        timeout = (60 * 10); # 10 Minutes
        command = "systemctl suspend";
      }
    ];
    events = [
      # TODO: Handle resume event
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock --daemonize -c ~/.config/swaylock/config";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock --daemonize -c ~/.config/swaylock/config";
      }
    ];
  };
}
