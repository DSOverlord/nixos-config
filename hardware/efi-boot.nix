{ config, lib, ... }:
let
  cfg = config.hardware.presets.efiBoot;
in

with lib;

{
  options.hardware.presets.efiBoot = mkEnableOption "Enable efi boot preset";

  config = mkIf cfg {
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };
    };
  };
}
