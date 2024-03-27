{
  home-manager.sharedModules = [{
    programs.foot.settings = {
      cursor.style = "beam";
      mouse.hide-when-typing = "yes";
      key-bindings.clipboard-paste = "Control+v";

      cursor.color = "111111 cccccc";
    };
  }];
}
