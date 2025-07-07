{ pkgs, ... }:
{
  home = {
    file = {
      ".local/share/themes/Clia" = {
        source = ../../assets/Clia;
        recursive = true;
      };
    };
  };

  wayland.windowManager.labwc = {
    enable = true;
    autostart = [
      "${pkgs.blueman}/bin/blueman-applet &"
      "${pkgs.xfce.xfce4-panel}/bin/xfce4-panel &"
      "${pkgs.light}/bin/light -S 50 &"
      "${pkgs.swaybg}/bin/swaybg -i ~/.config/wallpapers/wallhaven-45kjv5.jpg &"
      "${pkgs.networkmanagerapplet}/bin/nm-applet &"
      "${pkgs.waybar}/bin/waybar &"
    ];
    environment = [
      "XDG_CURRENT_DESKTOP=labwc:wlroots"
      "XKB_DEFAULT_LAYOUT=us"
      "WLR_NO_HARDWARE_CURSORS=1"
      "NIXOS_OZONE_WL=1"
      "MOZ_ENABLE_WAYLAND=1"
      "ELECTRON_OZONE_PLATFORM_HINT=1"
    ];
    xwayland.enable = false;
    systemd = {
      enable = true;
      extraCommands = [
        "systemctl --user restart emacs"
        "systemctl --user restart xdg-desktop-portal"
        "systemctl --user restart pipewire"
        "systemctl --user restart kanshi"
        "systemctl --user restart swayidle"
        "systemctl --user restart app-com.cloudflare.WarpTaskbar@autostart.service"
      ];
    };
    rc = {
      theme = {
        name = "Clia";
        cornerRadius = 0;
        font = {
          "@name" = "Inter";
          "@size" = 13;
        };
      };
      keyboard = {
        default = true;
        keybind = [
          {
            "@key" = "XF86AudioMute";
            action = {
              "@name" = "Execute";
              "@command" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            };
          }
          {
            "@key" = "XF86AudioMicMute";
            action = {
              "@name" = "Execute";
              "@command" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
            };
          }
          {
            "@key" = "XF86AudioRaiseVolume";
            action = {
              "@name" = "Execute";
              "@command" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
            };
          }
          {
            "@key" = "XF86AudioLowerVolume";
            action = {
              "@name" = "Execute";
              "@command" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            };
          }

          {
            "@key" = "XF86AudioMedia";
            action = {
              "@name" = "Execute";
              "@command" = "playerctl play-pause";
            };
          }
          {
            "@key" = "XF86AudioPlay";
            action = {
              "@name" = "Execute";
              "@command" = "playerctl play-pause";
            };
          }
          {
            "@key" = "XF86AudioPrev";
            action = {
              "@name" = "Execute";
              "@command" = "playerctl previous";
            };
          }
          {
            "@key" = "XF86AudioNext";
            action = {
              "@name" = "Execute";
              "@command" = "playerctl next";
            };
          }

          {
            "@key" = "XF86_MonBrightnessUp";
            action = {
              "@name" = "Execute";
              "@command" = "${pkgs.light}/bin/light -A 10";
            };
          }
          {
            "@key" = "XF86_MonBrightnessDown";
            action = {
              "@name" = "Execute";
              "@command" = "${pkgs.light}/bin/light -U 10";
            };
          }
          {
            "@key" = "W-e";
            action = {
              "@name" = "Execute";
              "@command" = "${pkgs.emacs-pgtk}/bin/emacsclient -c";
            };
          }
          {
            "@key" = "W-f";
            action = {
              "@name" = "Execute";
              "@command" = "${pkgs.xfce.thunar}/bin/thunar";
            };
          }
          {
            "@key" = "W-q";
            action = {
              "@name" = "Close";
            };
          }
          {
            "@key" = "W-1";
            action = {
              "@name" = "GoToDesktop";
              "@to" = "1";
            };
          }
          {
            "@key" = "W-S-1";
            action = {
              "@name" = "SendToDesktop";
              "@to" = "1";
            };
          }
          {
            "@key" = "W-2";
            action = {
              "@name" = "GoToDesktop";
              "@to" = "2";
            };
          }
          {
            "@key" = "W-S-2";
            action = {
              "@name" = "SendToDesktop";
              "@to" = "2";
            };
          }
          {
            "@key" = "W-3";
            action = {
              "@name" = "GoToDesktop";
              "@to" = "3";
            };
          }
          {
            "@key" = "W-S-3";
            action = {
              "@name" = "SendToDesktop";
              "@to" = "3";
            };
          }
          {
            "@key" = "W-4";
            action = {
              "@name" = "GoToDesktop";
              "@to" = "4";
            };
          }
          {
            "@key" = "W-S-4";
            action = {
              "@name" = "SendToDesktop";
              "@to" = "4";
            };
          }
          {
            "@key" = "W-f";
            action = {
              "@name" = "Maximize";
            };
          }
          {
            "@key" = "W-S-f";
            action = {
              "@name" = "ToggleFullscreen";
            };
          }
          {
            "@key" = "W-S-l";
            action = {
              "@name" = "Execute";
              "@command" = "${pkgs.swaylock}/bin/swaylock --daemonize";
            };
          }
          {
            "@key" = "W-Return";
            action = {
              "@name" = "Execute";
              "@command" = "${pkgs.foot}/bin/foot";
            };
          }
          {
            "@key" = "W-R";
            action = {
              "@name" = "Execute";
              "@command" = "wl-capture-region";
            };
          }
          {
            "@key" = "W-S-Return";
            action = {
              "@name" = "Execute";
              "@command" = "${pkgs.foot}/bin/foot";
            };
          }
          {
            "@key" = "W-x";
            action = {
              "@name" = "Execute";
              "@command" = "${pkgs.rofi-wayland}/bin/rofi -show drun";
            };
          }
        ];
      };
      focus = {
        followMouse = "no";
        raiseOnFocus = "yes";
      };
      mouse = {
        default = true;
      };
      desktops = {
        names = [
          {
            name = "Emacs";
          }
          {
            name = "Web";
          }
          {
            name = "Terms";
          }
          {
            name = "Others";
          }
        ];
      };
    };
    menu = [
      {
        menuId = "client-menu";
        label = "Menu";
        icon = "";
        items = [
          {
            label = "Minimize";
            action = {
              name = "Iconify";
            };
          }
          {
            label = "Maximize";
            action = {
              name = "ToggleMaximize";
            };
          }
          {
            label = "Fullscreen";
            action = {
              name = "ToggleFullscreen";
            };
          }
          {
            label = "Roll up/down";
            action = {
              name = "ToggleShade";
            };
          }
          {
            label = "Decorations";
            action = {
              name = "ToggleDecorations";
            };
          }
          {
            label = "Always on Top";
            action = {
              name = "ToggleAlwaysOnTop";
            };
          }
          {
            separator = true;
          }
          {
            menuId = "workspaces";
            label = "Workspace";
            items = [
              {
                label = "Move left";
                action = {
                  name = "SendToDesktop";
                  "@to" = "left";
                };
              }
              {
                label = "Move right";
                action = {
                  name = "SendToDesktop";
                  "@to" = "right";
                };
              }
              { separator = true; }
              {
                label = "Always on Visible Workspace";
                action = {
                  name = "ToggleOmnipresent";
                };
              }
            ];
          }
          {
            label = "Close";
            action = {
              name = "Close";
            };
          }
        ];
      }
      {
        menuId = "root-menu";
        items = [
          {
            label = "Foot";
            action = {
              name = "Execute";
              command = "${pkgs.foot}/bin/foot";
            };
          }
          {
            label = "Foot (Client)";
            action = {
              name = "Execute";
              command = "${pkgs.foot}/bin/footclient";
            };
          }
          {
            label = "Emacs (Client)";
            action = {
              name = "Execute";
              command = "${pkgs.emacs-pgtk}/bin/emacsclient -c";
            };
          }
          {
            label = "Emacs";
            action = {
              name = "Execute";
              command = "${pkgs.emacs-pgtk}/bin/emacs";
            };
          }
          {
            separator = true;
            label = "Work";
          }
          {
            label = "Brave";
            action = {
              name = "Execute";
              command = "brave";
            };
          }
          {
            label = "Chrome";
            action = {
              name = "Execute";
              command = "google-chrome-stable";
            };
          }
          {
            label = "Slack";
            action = {
              name = "Execute";
              command = "slack";
            };
          }
          {
            separator = true;
          }
          {
            label = "Reconfigure";
            action = {
              name = "Reconfigure";
            };
          }
          {
            label = "Exit";
            action = {
              name = "Exit";
            };
          }
        ];
      }
    ];
  };
}
