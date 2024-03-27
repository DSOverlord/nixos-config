{ pkgs, config, ... }:
{
  services.greetd = {
    enable = config.programs.xwayland.enable || config.xdg.portal.wlr.enable;
    settings = rec {
      initial_session = {
        command = "${pkgs.${config.defaultApps.environment}}/bin/${pkgs.${config.defaultApps.environment}.meta.mainProgram}";
        user = config.user;
      };
      default_session = initial_session;
    };
  };

  services.xserver.displayManager = {
    lightdm.enable = if (config.defaultApps.environment != null) then !config.services.greetd.enable else false;
    autoLogin.enable = true;
    autoLogin.user = config.user;
  };
}
