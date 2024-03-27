{ config, lib, ... }:
{
  home-manager.sharedModules = [{
    programs.nixvim = {
      defaultEditor = lib.mkIf (config.defaultApps.editor == "nixvim") true;

      viAlias = true;
      vimAlias = true;

      colorschemes.onedark.enable = true;
      highlightOverride.Normal.bg = "#0e0d14";

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      options = {
        updatetime = 100;

        number = true;

        tabstop = 4;
        shiftwidth = 4;
        expandtab = true;
        autoindent = true;
      };

      keymaps =
        let
          normal =
            lib.mapAttrsToList
              (key: action: {
                mode = "n";
                inherit action key;
              })
              {
                "<Space>" = "<NOP>";

                "a" = "i";
                "x" = "v0o$";
                "q" = ":q<CR>";
                "<C-s>" = ":w<CR>";
                "<C-c>" = ":yank<CR>";
              };
          visual =
            lib.mapAttrsToList
              (key: action: {
                mode = "v";
                inherit action key;
              })
              { };
        in
        config.nixvim.helpers.keymaps.mkKeymaps
          { options.silent = true; }
          (normal ++ visual);

      plugins = {
        nvim-autopairs.enable = true;
        which-key.enable = true;

        lualine = {
          enable = true;
          theme = "onedark";
        };

        comment-nvim = {
          enable = true;
          toggler = { line = "<C-x>"; };
        };

        gitsigns = {
          enable = true;
          signs = {
            add.text = "+";
            change.text = "~";
          };
        };

        telescope = {
          enable = true;

          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";

            "<C-f>" = "live_grep";
          };

          defaults = {
            file_ignore_patterns = [
              "^.git/"
              "^.mypy_cache/"
              "^__pycache__/"
              "^output/"
              "^data/"
              "%.ipynb"
            ];
            set_env.COLORTERM = "truecolor";
          };
        };

        conform-nvim = {
          enable = true;
          formatOnSave.lspFallback = true;
          formatters = {
            nixpkgs-fmt = {
              command = "nixpkgs-fmt";
              args = [ "$FILENAME" ];
              stdin = false;
            };
            csharpier = {
              command = "dotnet-csharpier";
              args = [ "$FILENAME" ];
              stdin = false;
            };
          };

          formattersByFt = {
            nix = [ "nixpkgs-fmt" ];
            csharp = [ "csharpier" ];
          };
        };

        treesitter = {
          enable = true;
          nixGrammars = true;
          nixvimInjections = true;

          indent = true;
        };

        lsp = {
          enable = true;

          servers = {
            nil_ls.enable = true;
            csharp-ls.enable = true;
            # rust-analyzer.enable = true;
          };
        };

        lspkind = {
          enable = true;
          cmp = {
            enable = true;
            menu = {
              nvim_lsp = "[LSP]";
              nvim_lua = "[api]";
              path = "[path]";
              luasnip = "[snip]";
              buffer = "[buffer]";
              neorg = "[neorg]";
              cmp_tabby = "[Tabby]";
            };
          };
        };

        cmp-tabby.host = "http://localhost:8080";
        luasnip.enable = true;
        nvim-cmp = {
          enable = true;
          snippet.expand = "luasnip";

          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = {
              modes = [ "i" "s" ];
              action = "cmp.mapping.select_next_item()";
            };
          };

          sources = [
            { name = "path"; }
            { name = "nvim_lsp"; }
            { name = "cmp_tabby"; }
            { name = "luasnip"; }
            {
              name = "buffer";
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
            { name = "neorg"; }
          ];
        };
      };
    };
  }];
}
