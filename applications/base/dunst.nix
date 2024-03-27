{ config, lib, ... }:
{
  home-manager.sharedModules = [{
    services.dunst = {
      enable = lib.mkDefault (config.services.greetd.enable || config.services.xserver.windowManager.i3.enable);
      iconTheme.name = config.stylix.iconTheme.name;
      iconTheme.package = config.stylix.iconTheme.package;
      settings = {
        global = {
          follow = "mouse";
          indicate_hidden = "yes";
          shrink = "no";
          transparency = 0;
          separator_height = 2;
          padding = 8;
          horizontal_padding = 8;
          frame_width = 1;
          sort = "yes";
          idle_threshold = 0;
          icon_position = "off";
          corner_radius = 10;

          line-height = 0;
          markup = "full";
          format = "<b>%a</b>\n<i>%s</i>\n%b";
          alignment = "center";
          vertical_alignment = "center";
          show_age_threshold = -1;
          word_wrap = "yes";
          ellipsize = "middle";
          ignore_newline = "no";
          stack_duplicates = false;
          hide_duplicate_count = true;
          show_indicators = "no";

          origin = "bottom-right";
          offset = "5x5";

          mouse_right_click = "close_current";
          mouse_middle_click = "close_current";
          mouse_left_click = "do_action";
        };
        urgency_low.frame_color = lib.mkForce "#d0dfee";
      };
    };
  }];
}

