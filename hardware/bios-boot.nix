{ config, lib, ... }:
let
  cfg = config.hardware.presets.biosBoot;
in

with lib;

{
  options.hardware.presets.biosBoot = mkEnableOption "Enable mbr boot preset";

  config = mkIf cfg {
    boot.loader = {
      grub = {
        enable = lib.mkDefault true;
        efiSupport = false;
        configurationLimit = 5;
      };
    };
  };
}
