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
    discord
    harper
  ];

  programs.vscode = {
    enable = true;
  };
}
