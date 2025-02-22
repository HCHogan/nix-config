{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/mihomo
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS";
      fsType = "ext4";
    };
    "/var/log" = {
      fsType = "tmpfs";
    };
  };

  hardware.firmware = [
    pkgs.linux-firmware
  ];

  hardware.deviceTree.name = "rockchip/rk3568-nanopi-r5s.dtb";

  boot.tmp.useTmpfs = true;

  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible = {
      enable = true;
      useGenerationDeviceTree = true;
    };
    timeout = 1;
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_13;
  boot.kernelParams = [
    "console=tty0"
    "earlycon=uart8250,mmio32,0xfe660000"
  ];

  boot.growPartition = true;

  boot.initrd.availableKernelModules = [
    "sdhci_of_dwcmshc"
    "dw_mmc_rockchip"
    "analogix_dp"
    "io-domain"
    "rockchip_saradc"
    "rockchip_thermal"
    "rockchipdrm"
    "rockchip-rga"
    "pcie_rockchip_host"
    "phy-rockchip-pcie"
    "phy_rockchip_snps_pcie3"
    "phy_rockchip_naneng_combphy"
    "phy_rockchip_inno_usb2"
    "dwmac_rk"
    "dw_wdt"
    "dw_hdmi"
    "dw_hdmi_cec"
    "dw_hdmi_i2s_audio"
    "dw_mipi_dsi"
  ];

  powerManagement.cpuFreqGovernor = "schedutil";
  # networking.useDHCP =  true;

  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;
  networking.firewall.enable = false;
  networking.networkmanager.enable = true;

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    settings.substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    python3
    mc
    psmisc
    curl
    wget
    dig
    file
    nvd
    ethtool
    sysstat
    neovim
    vim
    gcc
    nil
    btop
    neofetch
    ripgrep
    starship
  ];

  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  users.users.nix = {
    isNormalUser = true;
    description = "nix";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    password = "nix";
  };

  services.openssh = {
    enable = true;
    ports = [ 22 2200 ];
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";
  };

  environment.etc = {
    "systemd/journald.conf.d/99-storage.conf".text = ''
      [Journal]
      Storage=volatile
    '';
  };

  systemd.network.links = {
    "10-lan1" = {
      matchConfig = {
        Path = "platform-3c0000000.pcie-pci-0000:01:00.0";
      };
      linkConfig = {
        Name = "lan1";
      };
    };
    "10-lan2" = {
      matchConfig = {
        Path = "platform-3c0400000.pcie-pci-0001:01:00.0";
      };
      linkConfig = {
        Name = "lan2";
      };
    };
    "10-wan0" = {
      matchConfig = {
        Path = "platform-fe2a0000.ethernet";
      };
      linkConfig = {
        Name = "wan0";
      };
    };
  };

  programs.zsh.enable = true;

  nixpkgs.hostPlatform = "aarch64-linux";
  system.stateVersion = "24.11";

}
