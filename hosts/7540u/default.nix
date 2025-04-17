{
  pkgs,
  inputs,
  usernames,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/mihomo
    ../../modules/grub
    ../../modules/tuigreet
    ../../modules/keyd
    ../../modules/fcitx5
    ../../modules/nerdfonts
    ../../modules/virtualisation
    ../../modules/catppuccin
  ];

  networking.hostName = "7540u"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Hongkong";

  # Configure network proxy if necessary
  networking.proxy.default = "http://127.0.0.1:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  nixpkgs.config.rocmSupport = true;

  # Enable the X11 windowing system.
  services.xserver.enable = false;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.zsh = {
    enable = true;
  };

  programs.nix-ld.enable = true;

  services.blueman.enable = true;

  services.desktopManager.cosmic.enable = true;
  # services.displayManager.cosmic-greeter.enable = true;

  services.power-profiles-daemon.enable = false;

  services.dae = {
    enable = false;
    configFile = "/etc/dae/config.dae";
    assets = with pkgs; [v2ray-geoip v2ray-domain-list-community];
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      #CPU_MIN_PERF_ON_AC = 0;
      #CPU_MAX_PERF_ON_AC = 100;
      #CPU_MIN_PERF_ON_BAT = 0;
      #CPU_MAX_PERF_ON_BAT = 20;

      STOP_CHARGE_THRESH_BAT0 = 95;
    };
  };

  # services.ollama = {
  #   enable = true;
  #   acceleration = "rocm";
  #   rocmOverrideGfx = "10.3.0";
  # };

  xdg.portal.wlr.enable = true;
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    # waybar.enable = true;
    hyprlock.enable = true;
    # thunar.enable = true;
    virt-manager.enable = true;
    xwayland.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.spice-vdagentd.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  environment = {
    variables = {
      EDITOR = "nvim";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.vscode-server.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    git
    gcc
    wqy_microhei
    ntfs3g
    qemu
    starship
    zsh
    brightnessctl
    duf
    gnumake
    flex
    bison
    elfutils
    libelf
    pkg-config
    clapper
    bat
    just
    mihomo
    clinfo

    #virtualisation
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    adwaita-icon-theme
    radeontop
    rocmPackages.rocm-smi
    btop-rocm
    corectrl
    nautilus
    # daed

    inputs.zen-browser.packages."${system}".default
  ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?
}
