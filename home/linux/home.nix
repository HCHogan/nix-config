{ inputs, config, pkgs, ... }: 

{
  imports = [
    ../base/home.nix
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

  home.packages = with pkgs;[
    spotify
    killall
    hyprpaper
    nwg-look
    pavucontrol
    grimblast
    wl-clipboard
    # wechat-uos-sandboxed
    blueman
    jetbrains.idea-ultimate
    android-tools
    inputs.nur-xddxdd.packages.${system}.baidunetdisk
    # mathematica
  ];
}
