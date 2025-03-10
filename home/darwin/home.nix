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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.vscode = {
    enable = true;
  };
}
