{pkgs, ...}: {
  imports = [
  ];

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
  ];
}
