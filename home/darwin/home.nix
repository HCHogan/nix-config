{pkgs, ...}: {
  imports = [
    ../../modules/kitty
  ];
  home.packages = with pkgs; [
    raycast
    warp-terminal
    jdk
    wezterm
  ];

  programs.vscode = {
    enable = true;
  };
}
