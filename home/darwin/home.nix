{pkgs, ...}: {
  home.packages = with pkgs; [
    raycast
    warp-terminal
    jdk
  ];
}
