{ pkgs, config, lib, ... }:
{
  services.xserver.windowManager.awesome.enable = lib.mkIf (config.defaultApps.environment == "awesome") true;

  home-manager.sharedModules = [{
    xdg.configFile."awesome/.luarc.json".source = (pkgs.formats.json { }).generate "" {
      diagnostics = {
        enable = true;
        globals = [
          "awesome"
          "button"
          "dbus"
          "client"
          "screen"
          "mouse"
          "root"
        ];
      };
      runtime = {
        version = "Lua ${pkgs.lua.version}";
        path = [
          "${pkgs.awesome}/share/awesome/lib/?.lua"
          "${pkgs.awesome}/share/awesome/lib/?/init.lua"
        ];
      };
      workspace = {
        libary = [
          "runtime/lua"
          "${pkgs.awesome}/share/awesome/lib"
        ];
        checkThirdParty = false;
        maxPreload = 2000;
        preloadFileSize = 1000;
      };
      misc.parameters = [ "--loglevel=trace" ];
      telemetry.enable = false;
    };
  }];
}
