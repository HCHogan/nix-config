{username}: {
  inputs,
  system,
  pkgs,
  ...
}: let
  lib = inputs.nixpkgs.lib;
in {
  imports = [
    ./core.nix
    # ./base/home.nix
  ];
  # ++ lib.optional (lib.hasInfix "linux" system) ./linux/home.nix
  # ++ lib.optional (lib.hasInfix "darwin" system) ./darwin/home.nix;

  home.packages = with pkgs; [
    lua-language-server
    nil
    alejandra
    duf
    just
  ];

  home.file.".zshrc".text = ''
    eval "$(starship init zsh)"
  '';

  xdg.configFile = {
    neofetch = {
      source = ../modules/neofetch;
      recursive = true;
    };
    "starship.toml" = {
      source = ../modules/starship/starship.toml;
    };
  };

  _module.args = {
    inherit inputs system username;
  };
}
