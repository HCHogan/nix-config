{ inputs, config, pkgs, kvim, ... }:

{
  # nixpkgs = {
  #   # overlays = [];
  #   config = {
  #     allowUnfree = true;
  #     allowUnfreePredicate = _: true;
  #   };
  # };

  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;
  #   executable = true;
  # };

  home.file.".test".text = ''
    text in home.nix
  '';

  home.file.".local/share/fonts/Recursive-Bold.ttf".source = ../../fonts/Recursive-Bold.ttf;
  home.file.".local/share/fonts/Recursive-Italic.ttf".source = ../../fonts/Recursive-Italic.ttf;
  home.file.".local/share/fonts/Recursive-Regular.ttf".source = ../../fonts/Recursive-Regular.ttf;
  home.file.wallpapers.source = ../../wallpapers;

  home.packages = with pkgs;[
    killall
    hyprpaper
    microsoft-edge
    google-chrome
    clash-verge-rev
    telegram-desktop
    fastfetch
    neofetch
    yazi
    wezterm
    nwg-look
    pavucontrol
    grimblast
    wl-clipboard

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
    blueman

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
    wechat-uos

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
    uv

    llvm
    nodejs_22

    haskell.compiler.ghc98
    cabal-install
    haskell.packages.ghc982.haskell-language-server
    cabal2nix
  ];


  programs.starship = {
    enable = true;
    # settings = {
    #   add_newline = false;
    #   aws.disabled = true;
    #   line_break.disabled = true;
    # };
  };


  programs.rofi = {
    enable = true;
    # plugins = [ pkgs.rofi-emoji ];
    # theme = ../../modules/rofi/config.rasi;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.git = {
    enable = true;
    userName = "Hank Hogan";
    userEmail = "ysh2291939848@outlook.com";
  };

  xdg.configFile = {
    nvim.source = "${kvim}";
    wezterm.source = pkgs.fetchFromGitHub {
      owner = "HCHogan";
      repo = "wezterm";
      rev = "main";
      sha256 = "sha256-IAKbtTOOZGGBbbWS/kSlAGUB0pkHTmdQe4kFP6wsDwY=";
    };
    waybar = {
      source = ../../modules/waybar;
      recursive = true;
    };
    neofetch = {
      source = ../../modules/neofetch;
      recursive = true;
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
