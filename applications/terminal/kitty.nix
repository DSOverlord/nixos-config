{
  home-manager.sharedModules = [{
    programs.kitty = {
      keybindings = {
        "ctrl+v" = "paste_from_clipboard";
      };
    };
  }];
}


