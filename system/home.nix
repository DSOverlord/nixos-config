{ pkgs, config, lib, ... }:
let
  environment = config.defaultApps.environment;
in
{
  imports = [ ./options ];

  home-manager.sharedModules = [
    ({ config, ... }: {
      programs = {
        bat.enable = true;
        fzf.enable = true;
        htop.enable = true;
        ripgrep.enable = true;
      };

      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        desktop = lib.mkIf (environment != "kde") null;
        music = null;
        templates = null;
        publicShare = null;
        videos = null;
      };

      home.activation."mimeapps-remove" = {
        before = [ "checkLinkTargets" ];
        after = [ ];
        data = "rm -f ${config.home.homeDirectory}/.config/mimeapps.list";
      };

      xdg.configFile = {
        "scripts/volume" = {
          executable = true;
          text = let pactl = "${pkgs.pulseaudio}/bin/pactl"; in ''
            #!/usr/bin/env bash

            msgTag=$1
            volume="$(${pactl} get-$1-volume $(${pactl} get-default-$1) | head -n 1 | awk '{print $5}' | tr -d %)"
            mute="$(${pactl} get-$1-mute $(${pactl} get-default-$1) | awk '{print $2}')"

            if [ $1 == "source" ]
              then msg="Микрофон"
              else msg="Звук"
            fi
          
            if [[ $volume == 0 || "$mute" == "да" ]]; then
                ${pkgs.libnotify}/bin/notify-send -a "changeVolume" -u low -t 1500 -i audio-volume-muted -h string:x-dunst-stack-tag:$msgTag "$msg заглушен"
            else
                ${pkgs.libnotify}/bin/notify-send -a "changeVolume" -u low -t 1500 -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
                -h int:value:$volume "$msg: ''${volume}%"
            fi
          '';
        };
      };
    })
  ];
}
