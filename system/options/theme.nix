{ pkgs, config, ... }:
{
  stylix = {
    targets.console.enable = false;

    base16Scheme = {
      base00 = "0e0d14";
      base01 = "121212";
      base02 = "3e4451";
      base03 = "545862";
      base04 = "5f81a5";
      base05 = "abb2bf";
      base06 = "b6bdca";
      base07 = "c8ccd4";
      base08 = "e06c75";
      base09 = "d19a66";
      base0A = "5f81a5";
      base0B = "98c379";
      base0C = "56b6c2";
      base0D = "61afef";
      base0E = "c678dd";
      base0F = "be5046";
    };

    cursor = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    fonts = {
      sizes.terminal = if (config.services.greetd.enable) then 15 else 13;
      monospace = {
        package = pkgs.source-code-pro;
        name = "Source Code Pro";
      };
    };

    image = ../../image.png;
  };

  home-manager.sharedModules = [{
    stylix.targets = {
      nushell.enable = false;
      helix.enable = false;
    };

    gtk = {
      enable = true;
      iconTheme = {
        name = config.stylix.iconTheme.name;
        package = config.stylix.iconTheme.package;
      };
    };

    qt = {
      enable = true;
      platformTheme = "qtct";
      style.name = "kvantum";
    };

    home.file.".icons/default/index.theme".text = ''
      [Icon Theme]
      Name=Default
      Comment=Default Cursor Theme
      Inherits=${config.stylix.cursor.name}
    '';

    xdg.configFile = {
      "Kvantum/MateriaDark".source = "${pkgs.materia-kde-theme}/share/Kvantum/MateriaDark";

      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=MateriaDark
      '';

      "qt5ct/qt5ct.conf".text = ''
        [Appearance]
        color_scheme_path=${pkgs.qt5ct}/share/qt5ct/colors/darker.conf
        custom_palette=false
        icon_theme=${config.stylix.iconTheme.name}
        standard_dialogs=default
        style=kvantum
      '';

      "qt6ct/qt6ct.conf".text = ''
        [Appearance]
        color_scheme_path=${pkgs.qt6ct}/share/qt6ct/colors/darker.conf
        custom_palette=false
        icon_theme=${config.stylix.iconTheme.name}
        style=kvantum
      '';
    };
  }];
}

