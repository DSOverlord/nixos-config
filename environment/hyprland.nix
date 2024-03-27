{ pkgs, config, lib, ... }:
{
  programs.hyprland.enable = lib.mkIf (config.defaultApps.environment == "hyprland") true;

  home-manager.sharedModules = [{
    wayland.windowManager.hyprland = {
      enable = config.programs.hyprland.enable;
      settings = {
        monitor = ", highres, auto, 1";
        "$mod" = "SUPER";

        env = [
          "WLR_DRM_NO_ATOMIC,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        ];

        exec-once = [
          "sleep 0.1 && ${pkgs.swaybg}/bin/swaybg -i ${config.stylix.image}"
          "QT_QPA_PLATFORMTHEME=gtk3 telegram-desktop"
        ];

        input = {
          follow_mouse = 1;

          kb_layout = "us,ru";
          kb_options = "grp:alt_shift_toggle";

          repeat_rate = 30;
          repeat_delay = 260;
        };

        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 2;

          apply_sens_to_raw = 0;

          layout = "dwindle";
          allow_tearing = true;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };

        decoration = {
          rounding = 0;
          blur.enabled = false;
        };

        animations = {
          enabled = false;
          animation = [
            "windows, 1, 4, default"
            "windowsOut, 1, 4, default, popin 80%"
            "workspaces, 1, 5, default"
          ];
        };

        dwindle = {
          pseudotile = 0;
          no_gaps_when_only = true;
        };

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bind = [
          ## Основные ##
          "$mod, Q, killactive"
          "$mod, M, fullscreen, 0"
          "$mod, W, togglegroup"
          "$mod, P, pseudo"
          "$mod SHIFT, Space, togglefloating"
          "$mod SHIFT, Q, exit"

          ## Запуск приложений ##
          "$mod, Return, exec, ${config.defaultApps.terminal}"
          "$mod, Space, exec, ${config.defaultApps.terminal} -T app_launcher -e ${pkgs.sway-launcher-desktop}/bin/sway-launcher-desktop"
          ",KP_Insert, exec, ${config.defaultApps.terminal} -e nu -e ya"
          ",KP_End, exec, ${config.defaultApps.browser}"
          ",KP_Down, exec, QT_QPA_PLATFORMTHEME=gtk3 telegram-desktop"
          ",KP_Down, workspace, 7"

          ",KP_Delete, exec, ~/.config/scripts/clipstore"
          "CTRL_SHIFT, KP_Delete, exec, clipcatctl clear && wl-copy TrE4zBQ!W"

          ## Мультимедийные клавиши ##
          ",KP_Multiply, exec, ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle && ~/.config/scripts/volume source"
          ",KP_Add, exec, ${pkgs.pamixer}/bin/pamixer -i 5 && ~/.config/scripts/volume sink"
          ",KP_Subtract, exec, ${pkgs.pamixer}/bin/pamixer -d 5 && ~/.config/scripts/volume sink"

          ",KP_Enter, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          "SHIFT, KP_Add, exec, ${pkgs.playerctl}/bin/playerctl next"
          "SHIFT, KP_Subtract, exec, ${pkgs.playerctl}/bin/playerctl previous"

          "SHIFT, Print, exec, ${pkgs.grim}/bin/grim - | wl-copy"
          '',Print, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy''

          ## Фокус ##
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "$mod, grave, changegroupactive"
          "$mod, grave, cyclenext"

          ## Рабочие столы ##
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"

          "$mod SHIFT, 1, movetoworkspacesilent, 1"
          "$mod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod SHIFT, 5, movetoworkspacesilent, 5"
          "$mod SHIFT, 6, movetoworkspacesilent, 6"
          "$mod SHIFT, 7, movetoworkspacesilent, 7"
          "$mod SHIFT, 8, movetoworkspacesilent, 8"
          "$mod SHIFT, 9, movetoworkspacesilent, 9"

          ## Сочетания по умолчанию ##
          ",XF86AudioMute, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle && ~/.config/scripts/volume sink"
          ",XF86AudioRaiseVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5% && ~/.config/scripts/volume sink"
          ",XF86AudioLowerVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5% && ~/.config/scripts/volume sink"
        ];

        windowrule = [
          "workspace 3, steam_app"
          "workspace 7 silent, org.telegram.desktop"

          "workspace 3, Godot"
          "tile, title:Godot"

          ## Cliphist ##
          "float, title:(copymanager)"
          "size 500 550, title:(copymanager)"
          "center, title:(copymanager)"
          "stayfocused, title:(copymanager)"
          "dimaround, title:(copymanager)"

          ## Launcher ##
          "float, title:(app_launcher)"
          "size 25% 100%, title:(app_launcher)"
          "move 0 0, title:(app_launcher)"
          "noborder, title:(app_launcher)"
          "stayfocused, title:(app_launcher)"
          "dimaround, title:(app_launcher)"
        ];

        windowrulev2 = [
          "immediate, class:^(steam_app)$"
        ];
      };
    };
  }];
}
