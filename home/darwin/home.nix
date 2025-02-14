{pkgs, ...}: {
  home.packages = with pkgs; [
    raycast
    warp-terminal
    jdk
  ];

  programs.vscode = {
    enable = true;
  };
}
