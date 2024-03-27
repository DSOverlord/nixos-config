{
  home-manager.sharedModules = [{
    programs.alacritty.settings = {
      cursor.style.shape = "Beam";
      mouse.hide_when_typing = true;

      keyboard.bindings = [
        { mods = "Control"; key = "V"; action = "Paste"; }
      ];

      colors.bright.green = "0x56b6c2";
    };
  }];
}
