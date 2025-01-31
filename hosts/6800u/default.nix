# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../modules/system.nix
      ./hardware-configuration.nix
      ../../modules/mihomo
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      theme = "${inputs.grub-catppuccin.outPath}/src/catppuccin-mocha-grub-theme";
    };
    efi = {
      efiSysMountPoint = "/efi";
      canTouchEfiVariables = true;
    };
  };
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "6800u"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/HongKong";

  # Configure network proxy if necessary
  networking.proxy.default = "http://127.0.0.1:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # drivers.amdgpu.enable = true;
  # Enable the X11 windowing system.
  services.xserver.enable = false;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
        user = "hank";
      };
    };
  };
  programs.zsh = {
    enable = true;
    # shellInit = ''
    # eval "$(starship init zsh)"
    # '';
  };

  services.blueman.enable = true;


  # services.desktopManager.cosmic.enable = true;
  # services.displayManager.cosmic-greeter.enable = true;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
            esc = "capslock";
          };
        };
      };
    };
  };

  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq = {
    enable = false;
    # settings = {
    #   charger = {
    #     governor = "performance";
    #     turbo = "auto";
    #   };
    #   battery = {
    #     governor = "powersave";
    #     turbo = "auto";
    #   };
    # };
  };
  # services.tlp = {
  #   enable = true;
  # };

  services.dae = {
    enable = false;

    # openFirewall = {
    #   enable = true;
    #   port = 12345;
    # };

    # configFile = "${inputs.dae-config.outPath}/config.dae";
    configFile = "/etc/dae/config.dae";
    assets = with pkgs; [ v2ray-geoip v2ray-domain-list-community ];
    /* default options

    package = inputs.daeuniverse.packages.x86_64-linux.dae;
    disableTxChecksumIpGeneric = false;

    */

    # alternative of `assets`, a dir contains geo database.
    # assetsPath = "/etc/dae";
  };

  xdg.portal.wlr.enable = true;
  programs = {
    # clash-verge = {
    #   enable = true;
    # };
    hyprland = {
      enable = true;
      withUWSM = true;
      # set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    # waybar.enable = true;
    hyprlock.enable = true;
    # thunar.enable = true;
    virt-manager.enable = true;
    xwayland.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
  };
  i18n.inputMethod.fcitx5 = {
    waylandFrontend = true;
    addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-mozc
      fcitx5-gtk #  Fcitx5 gtk im module and glib based dbus client library
      fcitx5-material-color
    ];
    settings = {
      addons = {
        classicui.globalSection.Theme = "Material-Color-deepPurple";
        classicui.globalSection.DarkTheme = "Material-Color-deepPurple";
        # pinyin.globalSection = {
        #   PageSize = 9;
        #   CloudPinyinEnabled = "True";
        #   CloudPinyinIndex = 2;
        # };
        # cloudpinyin.globalSection = {
        #   Backend = "Baidu";
        # };
      };
      #globalOptions = { "Hotkey/TriggerKeys" = { "0" = "Alt+space"; }; };
      inputMethod = {
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "keyboard-us";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "shuangpin";
        GroupOrder."0" = "Default";
      };
    };
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
    nautilus
    # daed

    inputs.zen-browser.packages."${system}".default

    # pkgsCross.riscv64.gcc14

    # make waybar happy
    (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
      # select Python packages here
      pandas
      requests
    ]))
  ];

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

