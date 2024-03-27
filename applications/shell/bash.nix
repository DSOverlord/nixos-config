{ pkgs, config, lib, ... }:

with lib;

{
  environment.shellAliases = mkForce {
    nixos-switch = "sudo nixos-rebuild switch --flake ~/.config/nixos-config#${config.networking.hostName}";

    cat = "${pkgs.bat}/bin/bat";
    grep = "${pkgs.ripgrep}/bin/rg";
    find = "${pkgs.fd}/bin/fd";
    wget = "${pkgs.wget}/bin/wget --no-hsts";
    reboot = "systemctl reboot";
  };

  environment.etc.bashrc.text = mkAfter ''
    HISTCONTROL=erasedups
    HISTFILE=$HOME/.config/bash_history
    HISTFILESIZE=100000
    HISTSIZE=10000
  '';
}
