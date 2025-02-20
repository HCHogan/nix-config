{username}: {
  inputs,
  system,
  pkgs,
  ...
}: let
  lib = inputs.nixpkgs.lib;
in {
  imports =
    [
      ./core.nix
      # ./base/home.nix
    ];
    # ++ lib.optional (lib.hasInfix "linux" system) ./linux/home.nix
    # ++ lib.optional (lib.hasInfix "darwin" system) ./darwin/home.nix;

  _module.args = {
    inherit inputs system username;
  };
}
