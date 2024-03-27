{ pkgs, config, lib, ... }:
{
  xdg.portal.wlr.enable = lib.mkIf (config.defaultApps.environment == "sway") true;
  xdg.portal.config.common.default = "*";

  home-manager.sharedModules = lib.mkIf (config.defaultApps.environment == "sway") [
    ({ config, ... }: {
      home.sessionVariables = {
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      };

      wayland.windowManager.sway = {
        enable = true;
        systemd.enable = true;
        config = (config.xsession.windowManager.i3.config // {
          input."type:keyboard" = {
            xkb_layout = "us,ru";
            xkb_options = "grp:alt_shift_toggle";
            repeat_rate = "30";
            repeat_delay = "260";
          };

          keybindings = lib.mkOptionDefault {
            "Shift+Print" = "exec ${pkgs.grim}/bin/grim - | wl-copy";
            "Print" = ''exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy'';
          };

          startup = lib.mkForce [
            { command = "sleep 0.1 && ${pkgs.swaybg}/bin/swaybg -i ${config.stylix.image}"; }
            { command = "${pkgs.autotiling}/bin/autotiling"; }
            { command = "telegram-desktop"; }
          ];
        });
        extraConfig = "hide_edge_borders --i3 smart";
      };
    })
  ];
}
