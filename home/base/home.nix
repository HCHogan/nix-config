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

    # languages
    uv
    rustup
    # haskell.compiler.ghc910
    # haskell.packages.ghc9101.haskell-language-server
    # cabal-install
    # cabal2nix
    # cmake
    # ninja
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
