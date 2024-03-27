{ pkgs, ... }:
{
  defaultApps = {
    shell = "nushell";
    editor = "helix";
    environment = "hyprland";
    terminal = "alacritty";
    browser = "firefox";
  };

  home-manager.users.welius.programs.chromium.enable = true;

  ### Packages ###
  environment.systemPackages = with pkgs; [
    tdesktop
    openrgb
    yt-dlp
    r2modman
    localsend
    krita
    qbittorrent
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  virtualisation.podman.enable = true;

  ### Hardware ###
  hardware.presets = {
    nvidia = true;
    efiBoot = true;
  };
}
