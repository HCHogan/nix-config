{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/hyprland
    ../../modules/walker
    inputs.walker.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  # use qemu system session
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    nwg-look
    pavucontrol
    grimblast
    wl-clipboard
    blueman
    playerctl
    # cosmic-launcher

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

    # nix related
    nix-output-monitor

    # productivity
    hugo
    glow
    iotop
    iftop

    # syscall monitoring
    strace
    ltrace
    lsof

    # system tools
    sysstat
    lm_sensors
    ethtool
    pciutils # lspci
    usbutils # lsusb

    nur.repos.xddxdd.baidunetdisk
    nur.repos.nltch.spotify-adblock
    nur.repos.novel2430.wechat-universal-bwrap
    # jetbrains.idea-ultimate
    android-tools
    telegram-desktop
    wkhtmltopdf
    minicom
    vscode
    code-cursor
    davinci-resolve
    obs-studio
    warp-terminal
    qq
    vlc
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
