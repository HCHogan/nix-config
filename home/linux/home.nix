{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/hyprland
    inputs.walker.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
    ../../modules/walker
  ];

  catppuccin.gtk = {
    enable = true;
    accent = "lavender";
    icon.enable = true;
    icon.accent = "lavender";
  };
  catppuccin.yazi.enable = true;
  catppuccin.zellij.enable = true;

  programs.kitty.enable = true; # required for the default Hyprland config
  programs.firefox.enable = true;

  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  # Extra directories to add to PATH.
  home.sessionPath = [
    "$HOME/.ghcup/bin"
  ];

  home.packages = with pkgs; [
    hyprpaper
    nwg-look
    pavucontrol
    grimblast
    wl-clipboard
    blueman
    jetbrains.idea-ultimate
    android-tools
    nur.repos.xddxdd.baidunetdisk
    nur.repos.nltch.spotify-adblock
    nur.repos.novel2430.wechat-universal-bwrap
    telegram-desktop
    wkhtmltopdf
    minicom
    vscode
    code-cursor
    davinci-resolve
    obs-studio
    playerctl
    warp-terminal
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
