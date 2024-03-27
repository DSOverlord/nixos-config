{ pkgs, config, lib, ... }:
let
  cfg = config.hardware.presets.amdgpu;
in

with lib;

{
  options.hardware.presets.amdgpu = mkEnableOption "Enable amdgpu hardware preset";

  config = mkIf cfg {
    services.xserver.videoDrivers = [ "amdgpu" ];
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" "radeon.cik_support=0" "amdgpu.cik_support=1" ];

    hardware.opengl.extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };
}
