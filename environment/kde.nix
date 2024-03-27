{ pkgs, config, lib, ... }:
{
  config = lib.mkIf (config.defaultApps.environment == "kde") {
    environment.plasma5.excludePackages = with pkgs.libsForQt5; [
      oxygen
      konsole
      gwenview
      okular
      elisa
    ];

    qt.platformTheme = "kde";
    services.xserver = {
      desktopManager.plasma5.enable = true;
      displayManager.defaultSession = "plasmawayland";
    };
  };
}
