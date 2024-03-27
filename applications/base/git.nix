{ pkgs, config, lib, ... }:
{
  home-manager.sharedModules = [{
    programs.git = {
      enable = lib.mkDefault true;
      package = pkgs.gitFull;
      userName = "welius";
      userEmail = "dsoverlord@vk.com";
      extraConfig = {
        core.editor = pkgs."${config.defaultApps.editor}".meta.mainProgram;
        init.defaultBranch = "master";
        credential.helper = "store";
        push.autoSetupRemote = true;
      };
    };

    home.file.".git-credentials".source = config.age.secrets.git-credentials.path;
  }];
}
