{ pkgs, config, lib, ... }:
let
  cfg = config.hardware.presets.nvk;
in

with lib;

{
  options.hardware.presets.nvk = mkEnableOption "Enable nvk nvidia driver hardware preset";

  config = mkIf cfg {

    services.xserver.videoDrivers = [ "nouveau" ];

    boot.kernelParams = [
      "nouveau.config=NvGspRM=1"
      "nouveau.debug=info,VBIOS=info,gsp=debug"
    ];

    environment.variables = {
      VDPAU_DRIVER = "nouveau";
      WLR_NO_HARDWARE_CURSORS = "1";
      MESA_VK_VERSION_OVERRIDE = "1.3";
      __GLX_VENDOR_LIBRARY_NAME = "mesa";
      GALLIUM_DRIVER = "zink";
    };
  };
}

