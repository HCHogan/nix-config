{pkgs, ...}: {
  imports = [
    ../../modules/kitty
  ];
  home.packages = with pkgs; [
    swiftlint
    raycast
    warp-terminal
    jdk
    wezterm
    spotify
    discord
    harper
    emacs
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.vscode = {
    enable = true;
  };
}
