{username}: {
  inputs,
  system,
  pkgs,
  ...
}: let
  lib = inputs.nixpkgs.lib;
in {
  imports =
    [
      (import ./core.nix {inherit username;})
      ./base/home.nix
      ../modules/hyprland
      inputs.walker.homeManagerModules.default
      inputs.catppuccin.homeManagerModules.catppuccin
      ../modules/walker
    ]
    ++ lib.optional (lib.hasInfix "linux" system) ./linux/home.nix
    ++ lib.optional (lib.hasInfix "darwin" system) ./darwin/home.nix;

  programs.git = {
    enable = true;
    userName = "Hank Hogan";
    userEmail = "ysh2291939848@outlook.com";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.starship = {
    enable = true;
    enableTransience = true;
    enableZshIntegration = true;
  };

  xdg.configFile = {
    nvim.source = inputs.kvim.outPath;
    zsh.source = inputs.zsh-config.outPath;
    wezterm.source = inputs.wezterm-config.outPath;
    waybar = {
      source = ../modules/waybar;
      recursive = true;
    };
    neofetch = {
      source = ../modules/neofetch;
      recursive = true;
    };
    "starship.toml" = {
      source = ../modules/starship/starship.toml;
    };
  };

  home.file.".zshenv".text = ''
    ZDOTDIR=$HOME/.config/zsh
  '';

  home.file.".local/share/fonts/Recursive-Bold.ttf".source = ../fonts/Recursive-Bold.ttf;
  home.file.".local/share/fonts/Recursive-Italic.ttf".source = ../fonts/Recursive-Italic.ttf;
  home.file.".local/share/fonts/Recursive-Regular.ttf".source = ../fonts/Recursive-Regular.ttf;
  home.file.wallpapers.source = ../wallpapers;

  home.packages = with pkgs; [
    nur.repos.xddxdd.baidunetdisk
    nur.repos.nltch.spotify-adblock
    nur.repos.novel2430.wechat-universal-bwrap
    jetbrains.idea-ultimate
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
