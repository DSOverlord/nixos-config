{ pkgs, config, lib, ... }:
let
  terminal = config.defaultApps.terminal;
  shell = config.defaultApps.shell;
in
{
  environment.systemPackages = lib.mkIf (terminal == "alacritty") [ pkgs.ueberzugpp ];

  home-manager.sharedModules = [
    ({ config, ... }: {
      programs.yazi = {
        enableBashIntegration = true;
        enableZshIntegration = lib.mkIf (shell == "zsh") true;
        enableFishIntegration = lib.mkIf (shell == "fish") true;
        enableNushellIntegration = lib.mkIf (shell == "nushell") true;

        settings.manager = {
          show_hidden = false;
          sort_dir_first = true;
        };

        keymap.manager.prepend_keymap = [
          { on = [ "G" ]; run = "shell --block 'tar -zcvf archive.tar.gz $(basename -a $@)'"; desc = "Create tar archive from selected files"; }
        ];
      };

      xdg = lib.mkIf config.programs.yazi.enable {
        desktopEntries.yazi = {
          name = "Yazi";
          exec = "${terminal} -e yazi %U";
          terminal = false;
          categories = [ "FileManager" "Utility" ];
          icon = "system-file-manager";
          mimeType = [ "inode/directory" ];
        };

        mimeApps.defaultApplications."inode/directory" = "yazi.desktop";
      };
    })
  ];
}

