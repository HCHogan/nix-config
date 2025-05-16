{
  inputs,
  usernames,
  system,
  ...
}: let
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  lib = pkgs.lib;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = lib.genAttrs usernames (name:
    {
      shell = pkgs.zsh;
      description = name;
    }
    // lib.optionalAttrs (!(lib.hasInfix "darwin" system)) {
      extraGroups = ["networkmanager" "wheel" "libvirtd" "dialout" "qemu-libvirtd" "video" "audio" "disk" "libvirt" "podman"];
      isNormalUser = true;
    }
    // lib.optionalAttrs (lib.hasInfix "darwin" system) {
      home = "/Users/${name}";
    });
}
