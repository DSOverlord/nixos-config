{ config, ... }:
{
  defaultApps = {
    shell = "nushell";
    editor = "helix";
    environment = "hyprland";
  };

  ### Hardware ###
  zramSwap = {
    enable = true;
    memoryPercent = 200;
  };

  hardware.presets = {
    biosBoot = true;
  };

  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
}

