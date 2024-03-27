{
  home-manager.sharedModules = [{
    programs.qutebrowser = {
      settings = {
        auto_save.session = true;
        session.lazy_restore = true;
        tabs.show = "multiple";
        tabs.position = "top";
        downloads.remove_finished = 0;
        tabs.favicons.show = "never";
        statusbar.show = "in-mode";
        content.autoplay = false;
        content.headers.accept_language = "ru-RU,en-US";
        content.javascript.clipboard = "access-paste";

        completion = {
          show = "auto";
          height = "40%";
          shrink = true;
        };

        colors = {
          webpage = {
            bg = "black";
            darkmode.enabled = true;
            darkmode.algorithm = "lightness-hsl";
            darkmode.policy.images = "smart";
            preferred_color_scheme = "dark";
          };
        };

        content.blocking = {
          method = "both";
          hosts.lists = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" "https://raw.githubusercontent.com/ProgramComputer/Easylist_adservers_hosts/main/RuAdList%2BEasyList/hosts" ];
          adblock.lists = [ "https://easylist.to/easylist/easylist.txt" "https://easylist.to/easylist/easyprivacy.txt" "https://easylist-downloads.adblockplus.org/ruadlist.txt" "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt" "https://easylist-downloads.adblockplus.org/bitblock.txt" "https://easylist-downloads.adblockplus.org/cntblock.txt" ];
        };
      };
    };
  }];
}
