{
  home-manager.sharedModules = [{
    programs.waybar = {
      settings = {
        mainBar = {
          mode = "invisible";
          layer = "top";
          position = "bottom";
          height = 30;
          spacing = 4;
          modules-left = [ "wlr/workspaces" "sway/workspaces" ];
          modules-right = [ "pulseaudio" "temperature" "clock" "sway/language" "tray" ];

          "wlr/workspaces" = {
            format = "{icon}";
            all-outputs = true;
            active-only = false;
            on-click = "activate";
            on-scroll-up = "hyprctl dispatch workspace e-1";
            on-scroll-down = "hyprctl dispatch workspace e+1";
            format-icons = {
              "1" = "I";
              "2" = "II";
              "3" = "III";
              "4" = "IV";
              "5" = "V";
              "6" = "VI";
              "7" = "VII";
              "8" = "VIII";
              "9" = "IV";
            };
          };

          "sway/workspaces" = {
            "disable-scroll" = false;
            "all-outputs" = true;
            "format" = "{icon}";
            "format-icons" = {
              "1" = "I";
              "2" = "II";
              "3" = "III";
              "4" = "IV";
              "5" = "V";
              "6" = "VI";
              "7" = "VII";
              "8" = "VIII";
              "9" = "IV";
            };
          };

          "sway/language" = {
            "format" = "{short}";
            "tooltip" = false;
          };

          "tray" = {
            spacing = 10;
            reverse-direction = true;
          };

          "clock" = {
            format-alt = "{:%A, %d %B}";
          };

          "temperature" = {
            "critical-threshold" = 80;
            "format" = "{temperatureC}°C {icon}";
            "format-icons" = [ "" "" "" ];
          };
        };
      };

      style = ''
        * {
            font-family: "monospace";
            font-size: 14px;
        }
      
        window#waybar {
           background-color: #1f212b;
           color: #ffffff;
           transition-property: background-color;
           transition-duration: .5s;
        }
      
        window#waybar.hidden {
           opacity: 0.2;
        }

        window#waybar.termite {
            background-color: #3F3F3F;
        }

        window#waybar.chromium {
            background-color: #000000;
            border: none;
        }

        #workspaces button {
            padding: 0px 0px 0px 0px;
            background-color: #1f212b;
            color: #ffffff;
            box-shadow: inset 0 -3px transparent;
            border: none;
            border-radius: 0;
        }

        /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
        #workspaces button:hover {
            background: rgba(0, 0, 0, 0.2);
            box-shadow: inset 0 -2px #ffffff;
        }

        #workspaces button.focused {
            background-color: #64727D;
            box-shadow: inset 0 -2px #ffffff;
        }

        #workspaces button.active {
            background-color: #0D1117;
            box-shadow: inset 0 -2px #ffffff;
        }

        #workspaces button.urgent {
            background-color: #eb4d4b;
        }

        #mode {
            background-color: #64727D;
            border-bottom: 3px solid #ffffff;
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
        #custom-media,
        #tray,
        #mode,
        #idle_inhibitor,
        #mpd {
            padding: 0 10px;
            color: #ffffff;
        }

        #window,
        #workspaces {
            margin: 0 4px;
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }

        #clock {
            background-color: #64727D;
        }

        #battery {
            background-color: #ffffff;
            color: #000000;
        }

        #battery.charging, #battery.plugged {
            color: #ffffff;
            background-color: #26A65B;
        }

        @keyframes blink {
            to {
                background-color: #ffffff;
                color: #000000;
            }
        }

        #battery.critical:not(.charging) {
            background-color: #f53c3c;
            color: #ffffff;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        label:focus {
            background-color: #000000;
        }

        #cpu {
            background-color: #2ecc71;
            color: #000000;
        }

        #memory {
            background-color: #9b59b6;
        }

        #disk {
            background-color: #964B00;
        }

        #backlight {
            background-color: #90b1b1;
        }

        #network {
            background-color: #2980b9;
        }

        #network.disconnected {
            background-color: #f53c3c;
        }

        #pulseaudio {
            background-color: #f1c40f;
            color: #000000;
        }

        #pulseaudio.muted {
            background-color: #90b1b1;
            color: #2a5c45;
        }

        #custom-media {
            background-color: #66cc99;
            color: #2a5c45;
            min-width: 100px;
        }

        #custom-media.custom-spotify {
            background-color: #66cc99;
        }

        #custom-media.custom-vlc {
            background-color: #ffa000;
        }

        #temperature {
            background-color: #f0932b;
        }

        #temperature.critical {
            background-color: #eb4d4b;
        }

        #tray {
            background-color: #2980b9;
        }

        #tray > .passive {
            -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: #eb4d4b;
        }

        #idle_inhibitor {
            background-color: #2d3436;
        }

        #idle_inhibitor.activated {
            background-color: #ecf0f1;
            color: #2d3436;
        }

        #mpd {
            background-color: #66cc99;
            color: #2a5c45;
        }

        #mpd.disconnected {
            background-color: #f53c3c;
        }

        #mpd.stopped {
            background-color: #90b1b1;
        }

        #mpd.paused {
            background-color: #51a37a;
        }

        #language {
            background: #00b093;
            color: #740864;
            padding: 0 5px;
            min-width: 16px;
        }

        #keyboard-state {
            background: #97e1ad;
            color: #000000;
            padding: 0 0px;
            margin: 0 5px;
            min-width: 16px;
        }

        #keyboard-state > label {
            padding: 0 5px;
        }

        #keyboard-state > label.locked {
            background: rgba(0, 0, 0, 0.2);
        }

      '';
    };
  }];
}

