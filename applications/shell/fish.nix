{ pkgs, config, lib, ... }:
{
  programs.fish.enable = lib.mkIf (config.defaultApps.shell == "fish") true;

  home-manager.sharedModules = [{
    programs.fish = {
      shellAliases = config.environment.shellAliases;
      plugins = [
        {
          name = "sponge";
          src = pkgs.fishPlugins.sponge;
        }
        {
          name = "colored-man-pages";
          src = pkgs.fishPlugins.colored-man-pages;
        }
      ];
    };
  }];
}


