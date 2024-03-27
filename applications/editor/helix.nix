{ config, ... }:
let
  terminal = config.defaultApps.terminal;
in
{
  home-manager.sharedModules = [
    ({ pkgs, config, lib, ... }: {
      programs.helix = {
        settings = {
          theme = "dark";

          editor = {
            true-color = true;
            soft-wrap.enable = true;
            cursor-shape.insert = "bar";

            statusline = {
              right = [ "version-control" "position" "file-type" ];
              mode = {
                normal = "NORMAL";
                insert = "INSERT";
                select = "SELECT";
              };
            };

            idle-timeout = 200;
            lsp = {
              auto-signature-help = false;
              display-messages = true;
            };
          };

          keys.select."C-c" = [ ":clipboard-yank" "normal_mode" "collapse_selection" ];
          keys.normal = {
            "C-s" = ":write-all";
            "C-q" = ":q!";
            "C-x" = "toggle_comments";
            "C-c" = ":clipboard-yank";
            "Y" = ":clipboard-yank";
            "a" = "insert_mode";
            "?" = [ "select_all" "select_regex" ];
            "q" = ":q";
          };
        };

        languages = {
          language-server = {
            scls.command = "${(pkgs.callPackage ../custom/scls.nix { })}/bin/simple-completion-language-server";
            csharp-ls.command = "csharp-ls";
            python-ls.command = "pyright-langserver";
            nc-gdscript = {
              command = "nc";
              args = [ "localhost" "6005" ];
            };
          };
          language = [
            { name = "markdown"; auto-format = true; language-servers = [ "marksman" "scls" ]; }
            { name = "lua"; auto-format = true; }
            { name = "python"; auto-format = true; formatter.command = "black"; language-servers = [ "python-ls" "scls" ]; }
            { name = "nix"; auto-format = true; formatter.command = "nixpkgs-fmt"; language-servers = [ "nil" "scls" ]; }
            { name = "c-sharp"; auto-format = true; formatter.command = "dotnet-csharpier"; language-servers = [ "csharp-ls" "scls" ]; }
            { name = "rust"; auto-format = true; language-servers = [ "rust-analyzer" "scls" ]; }

            {
              name = "gdscript";
              auto-format = true;
              formatter.command = "gdformat";
              formatter.args = [ "-" ];
              roots = [ "project.godot" ];
              language-servers = [ "nc-gdscript" "scls" ];
            }
          ];
        };

        themes.dark = {
          inherits = "onedark";
          palette = {
            white = "#908caa";
            black = "#0e0d14";
            light-black = "#171923";
            gray = "#171923";
            faint-gray = "#26233a";
          };

          "ui.cursor" = { fg = "#908caa"; bg = "#524f67"; };
          "ui.cursor.primary" = { fg = "#908caa"; bg = "#453f61"; };
          "ui.cursor.match" = { fg = "#61AFEF"; bg = "#403d52"; };

          "ui.selection.primary" = { bg = "#212432"; };
        };
      };

      xdg = lib.mkIf (config.programs.helix.enable) rec {
        desktopEntries.Helix = {
          name = "Helix";
          exec = "${terminal} -e hx %F";
          terminal = false;
          categories = [ "Utility" "TextEditor" ];
          icon = "helix";
          mimeType = [ "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++" ];
        };

        mimeApps.defaultApplications = with builtins;
          listToAttrs (map (x: { name = x; value = "Helix.desktop"; }) desktopEntries.Helix.mimeType);
      };
    })
  ];
}

