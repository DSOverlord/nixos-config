{ pkgs, config, lib, ... }:
let
  log = {
    emit_journald = true;
    emit_stdout = false;
    emit_stderr = false;
    level = "INFO";
  };
in
{
  services.clipcat.enable = lib.mkDefault false;

  home-manager.sharedModules = lib.mkIf config.services.clipcat.enable [
    ({ config, ... }: {
      xdg.configFile = {
        "clipcat/clipcat-menu.toml".source = (pkgs.formats.toml { }).generate "" {
          server_endpoint = "/run/user/1000/clipcat/grpc.sock";
          finder = "fzf";

          log = log;
        };

        "clipcat/clipcatctl.toml".source = (pkgs.formats.toml { }).generate "" {
          server_endpoint = "/run/user/1000/clipcat/grpc.sock";
          log = log;
        };

        "clipcat/clipcatd.toml".source = (pkgs.formats.toml { }).generate "" {
          daemonize = true;
          pid_file = "/run/user/1000/clipcatd.pid";
          max_history = 100;
          history_file_path = "${config.home.homeDirectory}/.config/clipcat/history";
          snippets = [ ];

          watcher = {
            load_current = true;
            enable_clipboard = true;
            enable_primary = false;
            enable_secondary = false;
            sensitive_x11_atoms = [ "x-kde-passwordManagerHint" ];
            filter_text_min_length = 1;
            filter_text_max_length = 20000000;
            denied_text_regex_patterns = [ ];
            capture_image = true;
            filter_image_max_size = 5242880;
          };

          grpc = {
            enable_http = false;
            enable_local_socket = false;
            host = "127.0.0.1";
            port = 45045;
            local_socket = "/run/user/1000/clipcat/grpc.sock";
          };

          desktop_notification = {
            enable = false;
            icon = "accessories-clipboard";
            timeout_ms = 2000;
            long_plaintext_length = 2000;
          };

          log = log;
        };

        "scripts/clipstore" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash

            if [ $(pgrep -f copymanager | wc -l) -gt 0 ]; then 
              kill $(pgrep -f copymanager)
            else
              FZF_DEFAULT_OPTS="--with-nth 2,3,4,5,6,7,8,9,10" alacritty -T copymanager -e clipcat-menu
            fi
          '';
        };
      };
    })
  ];
}
