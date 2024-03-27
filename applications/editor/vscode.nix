{ pkgs, ... }:
{
  home-manager.sharedModules = [{
    programs.vscode = {
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        ms-ceintl.vscode-language-pack-ru
        zhuangtongfa.material-theme
        pkief.material-icon-theme
        streetsidesoftware.code-spell-checker
        jnoortheen.nix-ide
      ];

      userSettings = {
        "workbench.colorTheme" = "One Dark Pro Darker";
        "workbench.iconTheme" = "material-icon-theme";
        "cSpell.language" = "en,ru";
        "editor.formatOnSave" = true;
        "editor.fontFamily" = "'Source Code Pro', 'monospace', monospace";
        "editor.autoClosingBrackets" = "always";

        "tabby.api.endpoint" = "http://localhost:8080";

        "nim.useNimsuggestCheck" = true;

        "python.analysis.inlayHints.functionReturnTypes" = true;
        "python.formatting.provider" = "black";
        # "python.languageServer" = "Pylance";
      };
    };
  }];
}
