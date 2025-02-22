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

  xdg.configFile = {
    "starship.toml" = {
      source = ../modules/starship/starship.toml;
    };
  };

  _module.args = {
    inherit inputs system username;
  };
}
