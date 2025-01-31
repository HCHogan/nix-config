{pkgs, ...}: {
  home.file.".test".text = ''
    text in home.nix
  '';

  home.packages = with pkgs; [
    microsoft-edge
    google-chrome
    fastfetch
    neofetch
    yazi
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

    # utils
    ripgrep
    jq
    yq-go
    eza
    fzf

    # languages
    uv
    rustup
    nodejs_22
    haskell.compiler.ghc910
    cabal-install
    haskell.packages.ghc9101.haskell-language-server
    # haskell.packages.ghc984.haskell-language-server
    # haskell.packages.ghc982.haskell-language-server
    # haskellPackages.haskell-language-server
    cabal2nix

    llvmPackages_latest.clangUseLLVM
    llvmPackages_latest.clang-tools
    llvmPackages_latest.compiler-rt
    # llvmPackages_latest.bintools
    llvmPackages_latest.llvm
    llvmPackages_latest.llvm-manpages
    llvmPackages_latest.mlir
    llvmPackages_latest.lldb
    llvmPackages_latest.lld
    llvmPackages_latest.libcxx
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
