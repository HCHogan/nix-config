{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ../../modules/system.nix
    ./hardware-configuration.nix
    ../../modules/mihomo
    ../../modules/grub
    ../../modules/tuigreet
    ../../modules/keyd
    ../../modules/fcitx5
    ../../modules/nerdfonts
  ];

  networking.hostName = "H610"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Hongkong";

  # Configure network proxy if necessary
  networking.proxy.default = "http://127.0.0.1:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;

  programs.zsh = {
    enable = true;
  };

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

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  hardware.graphics = {
    enable = true;
  };

  environment = {
    variables = {
      EDITOR = "nvim";
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
    waybar
    nwg-dock-hyprland
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
    corectrl
    # daed
    ddns-go

    inputs.zen-browser.packages."${system}".default

    # pkgsCross.riscv64.gcc14

    # make waybar happy
    (pkgs.python3.withPackages (python-pkgs:
      with python-pkgs; [
        # select Python packages here
        pandas
        requests
      ]))
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  systemd.services.ddns-go = {
    enable = true;
    description = "Simple and easy to use DDNS. Automatically update domain name resolution to public IP (Support Aliyun, Tencent Cloud, Dnspod, Cloudflare, Callback, Huawei Cloud, Baidu Cloud, Porkbun, GoDaddy...)";

    wants = ["network.target"];
    after = ["network-online.target"];

    serviceConfig = {
      StartLimitInterval = 5;
      StartLimitBurst = 10;
      ExecStart = "${pkgs.ddns-go.outPath}/bin/ddns-go \"-l\" \":9876\" \"-f\" \"300\" \"-cacheTimes\" \"5\" \"-c\" \"/home/genisys/.ddns_go_config.yaml\"";
      Restart = "always";
      RestartSec = 120;
      EnvironmentFile = "-/etc/sysconfig/ddns-go";
    };

    wantedBy = ["multi-user.target"];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
