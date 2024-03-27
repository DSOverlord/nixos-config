{ pkgs, lib, ... }:

with lib;

{
  imports = [
    ./theme.nix
    ./login-manager.nix
    ./wayland-base.nix
    ./default-apps.nix
  ];

  options = {
    user = mkOption {
      type = types.nonEmptyStr;
      default = "welius";
    };
    stateVersion = mkOption {
      type = types.nonEmptyStr;
      default = "23.11";
    };

    stylix.iconTheme = {
      name = mkOption {
        type = types.str;
        default = "Papirus-Dark";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.papirus-icon-theme;
      };
    };
  };
}
