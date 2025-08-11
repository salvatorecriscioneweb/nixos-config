{ pkgs, ... }:
{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 36;
        spacing = 8;
        position = "top";
        layer = "top";
        margin-left = 0;
        margin-right = 0;
        margin-top = 0;

        modules-left = [
          "niri/workspaces"
          "mpris"
        ];
        modules-center = [
          "idle_inhibitor"
          "pulseaudio"
          "cpu"
          "memory"
          "network"
          "temperature"
          "backlight"
          "keyboard-state"
          "battery"
        ];
        modules-right = [
          "tray"
          "clock"
        ];
        "mpris" = {
          format = "{status}: {dynamic}";
          dynamic-len = 100;
        };
        "keyboard-state" = {
          "numlock" = true;
          "capslock" = true;
          "format" = " {name} {icon}";
          "format-icons" = {
            "locked" = "";
            "unlocked" = "";
          };
        };
        "idle_inhibitor" = {
          "format" = "{icon} ";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "tray" = {
          "icon-size" = 20;
          "spacing" = 10;
        };
        "clock" = {
          # "timezone" = "Europe/Tallinn";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
        };
        "cpu" = {
          "format" = "{usage}% ";
          "tooltip" = false;
        };
        "memory" = {
          "format" = "{}% ";
        };
        "temperature" = {
          # "thermal-zone"= 2;
          "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
          "critical-threshold" = 80;
          "format" = "{temperatureC}°C";
        };
        "backlight" = {
          # "device": "acpi_video1",
          "format" = "{percent}% {icon}";
          "format-icons" = [
            ""
            ""
          ];
        };
        "battery" = {
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon} ";
          "format-charging" = "{capacity}%  ";
          "format-plugged" = "{capacity}%  ";
          "format-alt" = "{time} {icon}";
          # "format-full": "",
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "network" = {
          # "interface": "wlp2*", // (Optional) To force the use of this interface
          "format-wifi" = "{signalStrength}%   ";
          "format-ethernet" = "Connected  ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠ ";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        "pulseaudio" = {
          "format" = "{volume}% {icon}";
          "format-bluetooth" = "{volume}% {icon}";
          "format-bluetooth-muted" = "{icon} {format_source}";
          "format-muted" = "{format_source}";
          "format-source" = "";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
              ""
            ];
          };
        };
      };
    };

    style = ''
      #workspaces button {
          background: transparent;
          color: @base05;
          border: 0px solid #000000;
          padding-left: 8px;
          padding-right: 8px;
      }
      #workspaces button.focused {
          background: @base04;
          color: @base06;
          border: 0px solid #000000;
      }
    '';
  };
}
