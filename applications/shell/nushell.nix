{ pkgs, config, ... }:
{
  home-manager.sharedModules = [{
    programs.nushell = {
      configFile.source = "${pkgs.nushell.src}/crates/nu-utils/src/sample_config/default_config.nu";
      envFile.source = "${pkgs.nushell.src}/crates/nu-utils/src/sample_config/default_env.nu";

      extraConfig = ''
        $env.config = ($env.config | upsert show_banner false)
      '';

      extraEnv = ''
        $env.PROMPT_COMMAND_RIGHT = ""
      '';

      shellAliases = config.environment.shellAliases;
    };
  }];
}
