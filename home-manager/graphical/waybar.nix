{ pkgs, ... }:
{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 36;
        spacing = 8;
        position = "bottom";
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
      * {
          border: none;
          border-radius: 0px;
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: "Inter", Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
          background-color: #c0c0c0;
          color: #000000;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces button {
          background: #c0c0c0;
          color: #000000;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
          background: #008080;
          color: #c0c0c0;

      }

      #workspaces button.focused {
          background: #008080;
      }

      #workspaces button.focused:hover {
          background: #008080;
          color: #c0c0c0;
          border-bottom: 3px solid #000000;

      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #mode {
          background-color: #64727D;
          border-bottom: 3px solid #000000;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #mpris,
      #custom-launcher,
      #custom-power,
      #custom-layout,
      #custom-updater,
      #custom-snip,
      #custom-wallpaper,
      #tags,
      #taskbar,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd {
          padding: 0 10px;
          color: #000000;
      }

      #window,
      #workspaces {
          margin: 0px 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0px;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0px;
      }

      #clock {
          background-color: #c0c0c0;
          color: #000000;
      }

      #battery {
          background-color: #c0c0c0;
          color: #000000;
      }

      #battery.charging, #battery.plugged {
          color: #000000;
          background-color: #26A65B;
      }

      @keyframes blink {
          to {
              background-color: #000000;
              color: #c0c0c0;
          }
      }

      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #000000;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          background-color: #c0c0c0;
      }

      #cpu {
          background-color: #c0c0c0;
          color: #000000;
      }

      #memory {
          background-color: #c0c0c0;
          color: #000000;
      }

      #disk {
          background-color: #c0c0c0;
          color: #000000;
          border: 1px solid #000000;
      }

      #backlight {
          background-color: #90b1b1;
          border: 1px solid #000000;

      }

      #network {
          background-color: #c0c0c0;
          color: #000000;
      }

      #network.disconnected {
          background-color: #c0c0c0;
          color: red;
      }

      #pulseaudio {
          background-color: #c0c0c0;
          color: #000000;
      }

      #pulseaudio.muted {
          background-color: #c0c0c0;
          color: red;
      }

      #mpris {
          background-color: #c0c0c0;
          color: black;
      }

      #mpris.spotify {
          background-color: #c0c0c0;
          color: black;
      }

      #mpris.vlc {
          background-color: #c0c0c0;
          color: black;
      }

      #mpris.brave {
          background-color: #c0c0c0;
          color: black;
      }

      #custom-power{
          background-color: #c0c0c0;
          font-size: 18px;
          margin-right: 5px;
      }

      #custom-launcher{
          background-color: #c0c0c0;
          font-size: 20px;
          margin-left: 5px;
          border: 1px solid #000000;
      }

      #custom-layout{
          background-color: #c0c0c0;
          color: black;
          font-size:20px;
      }

      #custom-updater {
          background-color: #c0c0c0;
          color: black;
      }

      #custom-snip {
          background-color: #c0c0c0;
          color: skyblue;
          font-size: 20px;
      }

      #custom-wallpaper {
          background-color: #c0c0c0;
          color: pink;
          font-size: 20px;
      }

      #tags{
          background-color: #c0c0c0;
          font-size: 20px;
      }

      #tags button.occupied {
          color: pink;
          margin: 5px;
          background-color: #272727;
      }
      #tags button.focused {
          color: #c0c0c0;
          margin: 5px;
          background-color: black;
      }
      #tags button.urgent{
          color: red;
          margin: 5px;
          background-color:black;
      }


      #taskbar{
          background-color: #c0c0c0;
          border-radius: 0px 20px 20px 0px;
      }

      #temperature {
          background-color: #c0c0c0;
          color: #000000;
      }

      #temperature.critical {
          background-color: #eb4d4b;
      }

      #tray {
          background-color: #c0c0c0;
          color: #000000;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
          background-color: #c0c0c0;
          color: #000000;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #c0c0c0;
          color: #000000;
      }

      #idle_inhibitor {
          background-color: #c0c0c0;
      }

      #idle_inhibitor.activated {
          background-color: #c0c0c0;
          color: #000000;
          border-radius: 20px 0px 0px 20px;

      }

      #language {
          background-color: #c0c0c0;
          color: #000000;
          min-width: 16px;
      }

      #keyboard-state {
          background: #97e1ad;
          color: #c0c0c0;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0px 5px;
      }

      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }
    '';
  };
}
