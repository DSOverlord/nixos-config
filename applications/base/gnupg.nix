{
  home-manager.sharedModules = [
    ({ config, lib, ... }: {
      programs.gpg = {
        enable = lib.mkDefault true;
        homedir = "${config.home.homeDirectory}/.config/gnupg";
      };
    })
  ];
}

