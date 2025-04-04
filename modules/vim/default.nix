{pkgs, ...}: {
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lightline-vim
      iceberg-vim
      nerdtree
      haskell-vim
    ];
    extraConfig = builtins.readFile ./config.vim;
  };
}
