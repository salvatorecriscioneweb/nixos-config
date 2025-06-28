{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    settings = {
      mainBar =
        let
          margin = 0;
        in
        {
          height = 32;
          spacing = 8;
          position = "top";
          layer = "top";
          # margin-top = margin;
          margin-left = margin;
          margin-right = margin;
          margin-bottom = margin;
          modules-left = [
            "custom/empty-space"
            "power-profiles-daemon"
            "battery"
          ];
          modules-center = [ ];
          modules-right = [
            "backlight"
            "custom/separator"
            "tray"
            "custom/empty-space"
          ];
          "custom/separator" = {
            format = " | ";
          };
          "custom/empty-space" = {
            format = "  ";
          };
          "wlr/taskbar" = {
            on-click = "activate";
            on-click-middle = "close";
            ignore-list = [
              "foot"
            ];
          };
          "backlight" = {
            device = "intel_backlight";
            format = "ブライトネス [{percent}%]";
          };
          "battery" = {
            states = {
              good = 75;
              warning = 30;
              critical = 15;
            };
            format = "-バッテリー- [{capacity}%]";
            format-charging = "+バッテリー+ [{capacity}%]";
            format-plugged = "~バッテリ~ [{capacity}%]";
            format-alt = "{time}";
          };
          "tray" = {
            spacing = 12;
          };
          "network" = {
            format-wifi = "   [{essid}]";
            format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
            format-linked = "{ifname} [No IP]";
            format-disconnected = "Disconnected ";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };
          "power-profiles-daemon" = {
            format = "{icon}";
            tooltip = false;
            format-icons = {
              default = "";
              performance = "";
              balanced = "";
              power-saver = "";
            };
          };
        };
    };
    style = ''
      * {
          border: none;
          border-bottom: none;
          border-radius: 0;
          min-height: 0;
      }

      #tags button {
          opacity: 0.5;
      }
      #tags button.focused,
      #tags button.occupied,
      #tags button.urgent {
          border-bottom: none;
          opacity: 0.8;
      }
      #tags button.focused {
          color: @base08;
          opacity: 1;
      }
      window#waybar {
          border: 2px solid @base06;
          background: #f3e1f7;
      }
      #taskbar button.active {
         color: @base02;
      }
    '';
  };
}
