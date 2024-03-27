{ pkgs, config, lib, ... }:
let
  mkArr = with builtins; folder: (map (x: head (match "(.*)\\.nix" x)) (attrNames (readDir "${folder}")));
in

with lib;

{
  options.defaultApps = with builtins; {
    shell = mkOption {
      type = types.enum (mkArr ../../applications/shell);
      default = "bash";
    };
    editor = mkOption {
      type = types.enum (mkArr ../../applications/editor);
      default = "helix";
    };
    file-manager = mkOption {
      type = types.enum (mkArr ../../applications/file-manager);
      default = "yazi";
    };
    environment = mkOption {
      type = types.enum (mkArr ../../environment ++ [ null ]);
      default = null;
    };
    terminal = mkOption {
      type = types.enum (mkArr ../../applications/terminal);
      default = if (!config.services.greetd.enable) then "alacritty" else "foot";
    };
    browser = mkOption {
      type = types.enum (mkArr ../../applications/web);
      default = "firefox";
    };
  };

  config = {
    environment.variables = {
      EDITOR = pkgs."${config.defaultApps.editor}".meta.mainProgram;
    };
    users.defaultUserShell = pkgs."${config.defaultApps.shell}";

    home-manager.sharedModules = [{
      programs."${config.defaultApps.shell}".enable = true;
      programs."${config.defaultApps.editor}".enable = true;
      programs."${config.defaultApps.file-manager}".enable = true;
      programs."${config.defaultApps.terminal}".enable = lib.mkIf (config.defaultApps.environment != null) true;
      programs."${config.defaultApps.browser}".enable = lib.mkIf (config.defaultApps.environment != null) true;

      xdg.mimeApps = {
        enable = true;
        defaultApplications = with builtins;
          let
            archive = "org.kde.ark.desktop";
            editor = attrNames (readDir "${pkgs."${config.defaultApps.editor}"}/share/applications");
            browser = attrNames (readDir "${pkgs.${config.defaultApps.browser}}/share/applications");
          in
          {
            "application/zip" = archive;
            "application/rar" = archive;
            "application/7z" = archive;
            "application/*tar" = archive;

            "application/pdf" = browser;

            "text/html" = browser;
            "x-scheme-handler/http" = browser;
            "x-scheme-handler/https" = browser;
            "x-scheme-handler/about" = browser;
            "x-scheme-handler/unknown" = browser;

            "text/plain" = editor;
          };
      };
    }];
  };
}
