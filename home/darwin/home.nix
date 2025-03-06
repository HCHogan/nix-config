{pkgs, ...}: {
  imports = [
    ../../modules/kitty
  ];
  home.packages = with pkgs; [
    raycast
    warp-terminal
    jdk
    wezterm
    spotify
  ];

  programs.vscode = {
    enable = true;
  };
}
