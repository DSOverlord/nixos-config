{ config, lib, ... }:
{
  home-manager.sharedModules = [{
    programs.firefox = {
      policies = {
        AppAutoUpdate = false;
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DontCheckDefaultBrowser = true;
        DisableSetDesktopBackground = true;
        DisableSystemAddonUpdate = true;
        DisableFeedbackCommands = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";

        EnableTrackingProtection = {
          Value = true;
          Locked = false;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
        };

        Permissions.Location = {
          BlockNewRequests = true;
          Locked = true;
        };

        UserMessaging = {
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          Locked = true;
          MoreFromMozilla = false;
          SkipOnboarding = true;
          UrlbarInterventions = false;
          WhatsNew = false;
        };

        Extensions.Install = [
          "https://addons.mozilla.org/ru/firefox/downloads/latest/nicothin-space/latest.xpi"
          "https://addons.mozilla.org/ru/firefox/downloads/latest/darkreader/latest.xpi"
          "https://addons.mozilla.org/ru/firefox/downloads/latest/ublock-origin/latest.xpi"
          "https://addons.mozilla.org/ru/firefox/downloads/latest/bitwarden-password-manager/latest.xpi"
          "https://addons.mozilla.org/ru/firefox/downloads/latest/return-youtube-dislikes/latest.xpi"
          "https://addons.mozilla.org/ru/firefox/downloads/latest/sponsorblock/latest.xpi"
          "https://addons.mozilla.org/ru/firefox/downloads/latest/canvasblocker/latest.xpi"
          "https://addons.mozilla.org/ru/firefox/downloads/latest/обход-блокировок-рунета/latest.xpi"
          "https://addons.mozilla.org/ru/firefox/downloads/latest/undoclosetabbutton/latest.xpi"
        ];
      };

      profiles = {
        "default" = {
          isDefault = true;
          id = 0;

          userChrome = ''
            #alltabs-button {display: none;}
          '';

          search = {
            force = true;
            default = "DuckDuckGo";
            engines = {
              "Bing".metaData.hidden = true;
              "Google".metaData.hidden = true;
              "Amazon.com".metaData.hidden = true;
              "Wikipedia (en)".metaData.hidden = true;
              "Википедия (ru)".metaData.hidden = true;
              "Yandex" = {
                urls = [{ template = "https://yandex.ru/search/?text={searchTerms}"; }];
                iconUpdateURL = "https://yandex.ru/favicon.ico";
                definedAliases = [ "@ya" "@yandex" ];
              };
            };
          };

          bookmarks = [
            {
              name = "Nix sites";
              toolbar = true;
              bookmarks = [
                { name = "NixOS Search - Packages"; url = "https://search.nixos.org/packages?channel=unstable"; }
                { name = "NixOS Search - Options"; url = "https://search.nixos.org/options?channel=unstable"; }
                { name = "Appendix Home Manager Options"; url = "https://nix-community.github.io/home-manager/options.xhtml"; }
              ];
            }
          ];

          settings = {
            # App
            "general.smoothScroll" = false;
            "mousewheel.min_line_scroll_amount" = 20;
            "gfx.webrender.all" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "signon.rememberSignons" = false;
            "layout.css.prefers-color-scheme.content-override" = 0;
            "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;

            # Language
            "layout.spellcheckDefault" = 3;
            "general.useragent.locale" = "ru";
            "intl.accept_languages" = "ru,en";
            "intl.locale.requested" = "ru,en-US";
            "doh-rollout.home-region" = "RU";
            "spellchecker.dictionary" = "en,ru";

            # Browser
            "browser.startup.page" = 3;
            "browser.search.openintab" = true;
            "browser.aboutConfig.showWarning" = false;
            "browser.download.autohideButton" = false;
            "browser.bookmarks.addedImportButton" = true;
            "browser.newtabpage.activity-stream.feeds.topsites" = true;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
            "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf_-browser-action","sponsorblocker_ajay_app-browser-action","canvasblocker_kkapsner_de-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","save-to-pocket-button","fxa-toolbar-menu-button","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","_290ce447-2abb-4d96-8384-7256dd4a1c43_-browser-action","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","_4853d046-c5a3-436b-bc36-220fd935ee1d_-browser-action","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","_4853d046-c5a3-436b-bc36-220fd935ee1d_-browser-action","addon_darkreader_org-browser-action","canvasblocker_kkapsner_de-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","ublock0_raymondhill_net-browser-action","sponsorblocker_ajay_app-browser-action","_290ce447-2abb-4d96-8384-7256dd4a1c43_-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","_3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf_-browser-action"],"dirtyAreaCache":["nav-bar","unified-extensions-area","toolbar-menubar","TabsToolbar","PersonalToolbar"],"currentVersion":20,"newElementCount":8}'';
            "browser.newtabpage.pinned" = ''[{"url":"https://vk.com/","label":"VK","baseDomain":"vk.com"},{"url":"https://www.youtube.com/","label":"YouTube","baseDomain":"youtube.com"},{"url":"http://github.com","label":"GitHub","baseDomain":"github.com"},{"url":"https://codeberg.org/welius","label":"Codeberg","baseDomain":"codeberg.org"},{"url":"https://www.deepl.com/translator","label":"DeepL","baseDomain":"deepl.com"},{"url":"https://mail.tutanota.com/mail","label":"Tutanota"},{"url":"http://remanga.org","label":"ReManga","baseDomain":"remanga.org"},{"url":"https://author.today","label":"AuthorToday","baseDomain":"author.today"}]'';
            "extensions.pocket.enabled" = false;

            # Privacy
            "privacy.globalprivacycontrol.enabled" = true;
            "privacy.fingerprintingProtection" = true;
            "privacy.donottrackheader.enabled" = true;
            "dom.security.https_only_mode" = true;
            "dom.security.https_only_mode_ever_enabled" = true;
            "datareporting.healthreport.uploadEnabled" = false;
            "app.shield.optoutstudies.enabled" = false;
            "browser.tabs.tabmanager.enabled" = false;
            "extensions.webextensions.restrictedDomains" = "";

            # Nvidia
            "gfx.x11-egl.force-enabled" = lib.mkIf (builtins.elem "nvidia" config.services.xserver.videoDrivers) true;
            "widget.dmabuf.force-enabled" = lib.mkIf (builtins.elem "nvidia" config.services.xserver.videoDrivers) true;
          };
        };
        "clear" = {
          isDefault = false;
          id = 1;
        };
      };
    };
  }];
}
