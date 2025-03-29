{pkgs, ...}: {
  imports = [
    ../../modules/vim
  ];

  home.file.".test".text = ''
    text in home.nix
  '';

  home.packages = with pkgs; [
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
    sqlite
    sqlite-interactive

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
    just
  ];
  programs.zsh.enable = true;

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
