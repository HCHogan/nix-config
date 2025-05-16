# for standalone home manager module on non-nixos linux distros.
{inputs}: {configurations}: let
  nixpkgs = inputs.nixpkgs;
  listToAttrs = builtins.listToAttrs;
  hasInfix = nixpkgs.lib.hasInfix;
in {
}
