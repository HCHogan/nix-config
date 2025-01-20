{ pkgs, lib, username, inputs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    packages = with pkgs; [
      tree
    ];
  };

  nix.settings.trusted-users = [username];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nixpkgs = {
    # overlays = [];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix.settings = {
    substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  environment.localBinInPath = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
}
