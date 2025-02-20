{pkgs, ...}: {
  home.file.".test".text = ''
    text in home.nix
  '';

  home.packages = with pkgs; [
    wezterm

    # neovim dependencies
    typst
    tinymist
    typstyle
    marksman
    markdownlint-cli
    prettierd
    lua-language-server
    bash-language-server
    nil
    alejandra
    neovide
    nodejs_22

    # utils
    fastfetch
    neofetch
    yazi
    ripgrep
    jq
    yq-go
    eza
    fzf
    duf
    btop
    tldr
    tmux
    posting
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
