{ pkgs, config, lib, ... }:
{
  services.xserver.windowManager.i3.enable = lib.mkIf (config.defaultApps.environment == "i3") true;

  home-manager.sharedModules = [{
    xsession.windowManager.i3 = {
      enable = config.services.xserver.windowManager.i3.enable;
      config = rec {
        modifier = "Mod4";
        terminal = config.defaultApps.terminal;
        workspaceLayout = "tabbed";
        gaps.smartBorders = "on";
        # focus.wrapping = "yes";

        window = {
          titlebar = false;
          commands = [
            { command = "floating enable, sticky enable, resize set 25 ppt 100 ppt, move position 0 0"; criteria.title = "app_launcher"; }
            { command = "floating enable, sticky enable, resize set 25 ppt 50 ppt, focus"; criteria.title = "^copymanager$"; }
          ];
        };

        startup = [
          { command = "xset -dpms && xset s off"; notification = false; }
          { command = "xrandr --output DP-4 --mode 3440x1440 -r 144"; notification = false; }
          { command = "sleep 1 && i3-msg -t run_command workspace number 1"; notification = false; }
          { command = "${pkgs.feh}/bin/feh --bg-fill ${config.stylix.image}"; notification = false; }
          { command = "xset r rate 260 30"; notification = false; }
          { command = "${pkgs.autotiling}/bin/autotiling"; notification = false; }
          { command = "telegram-desktop"; notification = false; }
        ];

        keybindings = let exec = "exec --no-startup-id"; in lib.mkOptionDefault {
          "${modifier}+Return" = "${exec} ${terminal}";
          "${modifier}+space" = "${exec} ${terminal} -T app_launcher -e ${pkgs.sway-launcher-desktop}/bin/sway-launcher-desktop";
          "KP_Insert" = "${exec} ${config.defaultApps.terminal} -e yazi";
          "KP_End" = "${exec} ${config.defaultApps.browser}";
          "KP_Delete" = "${exec} ~/.config/scripts/clipstore";
          "Ctrl+Shift+KP_Delete" = "${exec} clipcatctl clear";
          "KP_Down" = "workspace number 10";

          "KP_Multiply" = "${exec} ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle && ~/.config/scripts/volume source";
          "KP_Add" = "${exec} ${pkgs.pamixer}/bin/pamixer -i 5 && ~/.config/scripts/volume sink";
          "KP_Subtract" = "${exec} ${pkgs.pamixer}/bin/pamixer -d 5 && ~/.config/scripts/volume sink";

          "KP_Enter" = "${exec} ${pkgs.playerctl}/bin/playerctl play-pause";
          "Shift+KP_Add" = "${exec} ${pkgs.playerctl}/bin/playerctl next";
          "Shift+KP_Subtract" = "${exec} ${pkgs.playerctl}/bin/playerctl previous";

          "Shift+Print" = "${exec} ${pkgs.scrot}/bin/scrot /tmp/image.png && ${pkgs.xclip}/bin/xclip -selection clipboard -target image/png -i /tmp/image.png && rm /tmp/image.png";
          "--release Print" = "${exec} ${pkgs.scrot}/bin/scrot /tmp/image.png -fs && ${pkgs.xclip}/bin/xclip -selection clipboard -target image/png -i /tmp/image.png && rm /tmp/image.png";

          "XF86AudioMute" = "${exec} ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle && ~/.config/scripts/volume sink";
          "XF86AudioRaiseVolume" = "${exec} ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5% && ~/.config/scripts/volume sink";
          "XF86AudioLowerVolume" = "${exec} ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5% && ~/.config/scripts/volume sink";

          "XF86AudioPlay" = "${exec} ${pkgs.playerctl}/bin/playerctl play-pause";
          "XF86AudioNext" = "${exec} ${pkgs.playerctl}/bin/playerctl next";
          "XF86AudioPrev" = "${exec} ${pkgs.playerctl}/bin/playerctl previous";

          "button2" = "kill";

          "${modifier}+w" = null;
          "${modifier}+e" = null;
          "${modifier}+v" = null;
          "${modifier}+d" = null;
        };

        keycodebindings = lib.mkOptionDefault {
          "${modifier}+24" = "kill";
          "${modifier}+25" = "layout tabbed";
          "${modifier}+26" = "layout toggle split";
          "${modifier}+49" = "focus next";
          "${modifier}+58" = "fullscreen toggle";
        };

        bars = [ ];

        assigns = {
          "3" = [{ class = "Godot"; }];
          "10" = [{ class = "telegram-desktop"; } { class = "TelegramDesktop"; }];
        };
      };
    };
  }];
}
