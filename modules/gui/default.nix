{
  pkgs,
  hostname,
  ...
}:
if hostname == "b660"
then {
  home.packages = with pkgs; [
    blueman
    spotify
    nix-output-monitor
    nur.repos.xddxdd.baidunetdisk
    # nur.repos.nltch.spotify-adblock
    nur.repos.novel2430.wechat-universal-bwrap
    # jetbrains.idea-ultimate
    android-tools
    telegram-desktop
    wkhtmltopdf
    minicom
    vscode
    code-cursor
    obs-studio
    warp-terminal
    qq
    vlc
    wezterm
    nautilus
  ];
}
else {}
