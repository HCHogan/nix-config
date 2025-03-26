{
  pkgs,
  inputs,
  ...
}: {
  imports =
    [
      ../../modules/hyprland
      ../../modules/walker
      ../../modules/tofi
      inputs.walker.homeManagerModules.default
      inputs.catppuccin.homeManagerModules.catppuccin
      ../../modules/kitty
      ../../modules/ghostty
      ../../modules/gui
    ];
    # ++ pkgs.lib.optional (hostname == "b660") [../../modules/gui];

  # use qemu system session
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # networking
    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc

    #misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    tree-sitter
    zinit

    # monitor
    iotop
    iftop
    strace
    ltrace
    lsof
    pstree

    # system tools
    sysstat
    lm_sensors
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  catppuccin.gtk = {
    enable = true;
    accent = "lavender";
    icon.enable = true;
    icon.accent = "lavender";
  };
  catppuccin.yazi.enable = true;
  catppuccin.zellij.enable = true;
  catppuccin.btop.enable = true;
}
