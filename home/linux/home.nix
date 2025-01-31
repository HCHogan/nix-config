{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/hyprland
  ];

  programs.kitty.enable = true; # required for the default Hyprland config
  programs.firefox.enable = true;

  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  # Extra directories to add to PATH.
  home.sessionPath = [
    "$HOME/.ghcup/bin"
  ];

  home.packages = with pkgs; [
    spotify
    hyprpaper
    nwg-look
    pavucontrol
    grimblast
    wl-clipboard
    # wechat-uos
    blueman
    jetbrains.idea-ultimate
    android-tools
    inputs.nur-xddxdd.packages.${system}.baidunetdisk
    # clash-verge-rev
    telegram-desktop
    wkhtmltopdf
    minicom

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
    qq
    vlc
    zinit

    # nix related
    nix-output-monitor

    # productivity
    hugo
    glow
    iotop
    iftop
    # btop-rocm
    btop

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
    # mathematica
  ];
}
