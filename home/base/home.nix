{ inputs, config, pkgs, ... }:

{
  # home.uesrname = "hank";
  nixpkgs = {
    # overlays = [];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
  home.homeDirectory = "/home/hank";

  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;
  #   executable = true;
  # };

  home.file.".test".text = ''
    text in home.nix
  '';

  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  home.packages = with pkgs;[
    fastfetch
    yazi

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep
    jq
    yq-go
    eza
    fzf

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

    # nix related
    nix-output-monitor

    # productivity
    hugo
    glow
    iotop
    iftop
    # btop

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

    # neovim dependencies
    typst
    tinymist
    typstyle
    marksman
    markdownlint-cli
    prettierd

    # languages
    llvm
    nodejs_22
  ];

  programs.git = {
    enable = true;
    userName = "Hank Hogan";
    userEmail = "ysh2291939848@outlook.com";
  };

  programs.starship = {
    enable = true;
    # settings = {
    #   add_newline = false;
    #   aws.disabled = true;
    #   line_break.disabled = true;
    # };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
  };

  xdg.configFile = {
    nvim.source = pkgs.fetchFromGitHub {
      owner = "HCHogan";
      repo = "kvim";
      rev = "master";
      sha256 = "sha256-vBko906PUuttA4qF/MnvYZf537bbrxxvctWG/LozMws=";
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
