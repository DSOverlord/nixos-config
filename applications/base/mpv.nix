{ pkgs, lib, ... }:
{
  home-manager.sharedModules = [
    ({ config, ... }: {
      programs.mpv = {
        enable = lib.mkDefault true;

        config = {
          fs = true;
          osc = false;
          loop-file = "inf";
          loop-playlist = "inf";
          image-display-duration = "inf";
        };

        profiles = {
          default = {
            window-dragging = true;
            title = ''''${?media-title:''${media-title}}''${!media-title:No file} - mpv'';
          };

          image = {
            window-dragging = false;
            title = ''''${?media-title:''${media-title}}''${!media-title:No file} [''${dwidth:X}x''${dheight:X}] - mvi'';
          };
        };

        bindings = {
          MBTN_RIGHT = "script-binding pan-follows-cursor";
          MBTN_LEFT = "script-binding drag-to-pan";
          WHEEL_UP = "{image-viewer} script-message cursor-centric-zoom 0.1";
          WHEEL_DOWN = "{image-viewer} script-message cursor-centric-zoom -0.1";

          UP = "{image-viewer} ignore";
          DOWN = "{image-viewer} ignore";
          RIGHT = "{image-viewer} repeatable playlist-next";
          LEFT = "{image-viewer} repeatable playlist-prev";

          SPACE = "{image-viewer} cycle_values image-display-duration inf 1 2";
        };

        scripts = with pkgs.mpvScripts; [
          mpris
          autoload
          thumbfast
          sponsorblock
          uosc
          (pkgs.callPackage ../custom/mvi.nix { })
        ];

        scriptOpts = {
          mvi = {
            command_on_image_loaded = "apply-profile image; enable-section image-viewer;";
            command_on_non_image_loaded = "apply-profile default; disable-section image-viewer; no-osd set pause no; no-osd set video-pan-x 0; no-osd set video-pan-y 0; no-osd set video-zoom 0";
          };

          uosc = {
            volume = "none";
          };
        };
      };

      xdg = lib.mkIf (config.programs.mpv.enable) rec {
        configFile."mpv/input.conf".text = lib.mkAfter ''
          RIGHT no-osd seek 5;
          LEFT no-osd seek -5;
          UP add volume 2
          DOWN add volume -2
        '';

        desktopEntries.mvi = {
          name = "mvi";
          exec = "mpv --profile=image %F";
          terminal = false;
          categories = [ "Graphics" "2DGraphics" "Viewer" ];
          icon = "multimedia-photo-viewer";
          mimeType = [ "image/bmp" "image/gif" "image/jpeg" "image/jpg" "image/pjpeg" "image/png" "image/tiff" "image/x-bmp" "image/x-pcx" "image/x-png" "image/x-portable-anymap" "image/x-portable-bitmap" "image/x-portable-graymap" "image/x-portable-pixmap" "image/x-tga" "image/x-xbitmap" "image/heif" ];
        };

        mimeApps.defaultApplications = with builtins;
          listToAttrs (map (x: { name = x; value = "mvi.desktop"; }) desktopEntries.mvi.mimeType);
      };
    })
  ];
}

