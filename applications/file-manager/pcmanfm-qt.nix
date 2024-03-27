{ pkgs, config, lib, ... }:

with lib;

let
  terminal = config.defaultApps.terminal;
in

{
  home-manager.sharedModules = [
    ({ config, ... }:
      let cfg = config.programs.pcmanfm-qt; in {
        options.programs.pcmanfm-qt = {
          enable = mkEnableOption "Enable pcmanfm-qt file manager";
          package = mkOption {
            type = types.package;
            default = pkgs.pcmanfm-qt;
          };

          settings = mkOption {
            type = pkgs.formats.toml { }.type;
            default = {
              System = {
                Archiver = "ark";
                Terminal = terminal;
              };
              FolderView = {
                BigIconSize = 64;
                SidePaneIconSize = 32;
              };
            };
          };
        };

        config = mkIf cfg.enable {
          home.packages = [ cfg.package ];
          xdg.configFile."pcmanfm-qt/default/settings.conf".source = pkgs.formats.ini { }.generate "settings" cfg.settings;
        };
      })
  ];
}
