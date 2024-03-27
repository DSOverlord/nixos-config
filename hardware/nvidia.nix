{ config, lib, ... }:
let
  cfg = config.hardware.presets.nvidia;
in

with lib;

{
  options.hardware.presets.nvidia = mkEnableOption "Enable nvidia hardware preset";

  config = mkIf cfg {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;

      nvidiaSettings = true;
    };

    environment.variables = {
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_VRR_ALLOWED = "0";

      MOZ_DISABLE_RDD_SANDBOX = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
