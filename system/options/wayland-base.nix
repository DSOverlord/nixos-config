{ pkgs, config, lib, ... }:
{
  config = lib.mkIf config.services.greetd.enable {
    environment.variables = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      GDK_BACKEND = "wayland,x11";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
    };

    environment.systemPackages = with pkgs; [
      wev
      wf-recorder
      wl-clipboard
    ];
  };
}
