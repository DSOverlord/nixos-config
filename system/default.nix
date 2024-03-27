{ pkgs, config, lib, inputs, modulesPath, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.disko.nixosModules.disko
    inputs.agenix.nixosModules.default

    (modulesPath + "/installer/scan/not-detected.nix")

    ./home.nix

    ../hardware/efi-boot.nix
    ../hardware/bios-boot.nix
    ../hardware/nvk.nix
    ../hardware/nvidia.nix
    ../hardware/amdgpu.nix

    ../applications/base/dunst.nix
    ../applications/base/gnupg.nix
    ../applications/base/git.nix
    ../applications/base/mpv.nix
    ../applications/base/clipcat.nix

    ../applications/shell/bash.nix
    ../applications/shell/fish.nix
    ../applications/shell/nushell.nix

    ../applications/editor/helix.nix
    ../applications/editor/nixvim.nix
    ../applications/editor/vscode.nix

    ../environment/sway.nix
    ../environment/hyprland.nix
    ../environment/i3.nix
    ../environment/awesome.nix
    ../environment/kde.nix

    ../applications/terminal/foot.nix
    ../applications/terminal/kitty.nix
    ../applications/terminal/alacritty.nix

    ../applications/file-manager/yazi.nix
    ../applications/file-manager/pcmanfm-qt.nix

    ../applications/web/firefox.nix
    ../applications/web/chromium.nix
    ../applications/web/qutebrowser.nix
  ];

  age.secrets = {
    password.file = ../secrets/password.age;
    git-credentials.file = ../secrets/git-credentials.age;

    nix-access-tokens = {
      file = ../secrets/nix-access-tokens.age;
      group = "wheel";
      mode = "0440";
    };
  };

  ### Networking ###
  networking = {
    networkmanager.enable = !config.networking.wireless.enable;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
  };

  ### Region ###
  i18n.defaultLocale = "ru_RU.UTF-8";
  time.timeZone = "Europe/Kaliningrad";
  console = {
    font = "cyr-sun16";
    keyMap = "us";
  };

  ### Users ###
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [{
      imports = [ inputs.nixvim.homeManagerModules.nixvim ];

      news.display = "silent";
      systemd.user.startServices = true;
      home.stateVersion = config.stateVersion;
    }];

    users."${config.user}".home = {
      username = config.user;
      homeDirectory = "/home/${config.user}";
    };

    users.root.home = {
      homeDirectory = "/root";
    };
  };

  users.users."${config.user}" = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.password.path;
    extraGroups = [ "wheel" "networkmanager" "adbusers" "video" "audio" "scanner" "lp" "docker" ];
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [ open-fonts nerdfonts ];
  };

  ### Services ###
  services = {
    acpid.enable = true;
    tumbler.enable = true;
    gvfs.enable = true;
    dbus.enable = true;
    upower.enable = true;
    earlyoom.enable = true;

    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];

      xkb = {
        layout = "us,ru";
        model = "pc105";
        options = "grp:alt_shift_toggle";
      };
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };

    openssh.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    NetworkManager-dispatcher.enable = false;
  };

  virtualisation = {
    podman.dockerCompat = true;
    oci-containers.backend = "podman";
    containers.cdi.dynamic.nvidia.enable = lib.mkIf (builtins.elem "nvidia" config.services.xserver.videoDrivers) true;
  };

  ### Programs ###
  environment.systemPackages = with pkgs; [
    nix-init
    appimage-run

    fd
    rar
    zip
    wget
    ffmpeg
    ddcutil
    playerctl
    libnotify
    coreutils
    lm_sensors
    ffmpegthumbnailer

    libva-utils
    vdpauinfo
    glxinfo

    nil
    nixpkgs-fmt
    marksman
    taplo

    pavucontrol
    inputs.agenix.packages.x86_64-linux.default
  ];

  programs = {
    mtr.enable = true;
    adb.enable = true;
    dconf.enable = true;
  };

  ### Nix ###
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
    };

    extraOptions = ''
      !include ${config.age.secrets.nix-access-tokens.path}
    '';

    gc = {
      automatic = true;
      dates = "18:00";
      options = "--delete-old";
    };

    optimise = {
      automatic = true;
      dates = [ "18:00" ];
    };
  };


  ### Hardware ###
  boot = {
    initrd.includeDefaultModules = true;
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  };

  hardware = {
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
    opengl.extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];

    i2c.enable = lib.mkDefault true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  system.stateVersion = config.stateVersion;
}
