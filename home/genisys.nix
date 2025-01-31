{
  inputs,
  pkgs,
  system,
  username,
  ...
}: let
  lib = pkgs.lib;
in {
  imports =
    [
      (import ./core.nix {inherit username;})
      ./base/home.nix
    ]
    ++ lib.optional (lib.hasInfix "linux" system) ./linux/home.nix
    ++ lib.optional (lib.hasInfix "darwin" system) ./darwin/home.nix;

}
