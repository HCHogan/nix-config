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

  nix.settings.trusted-users = usernames;
  nix.optimise.automatic = true;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 1w";
  };

  nixpkgs = {
    overlays = [
      inputs.hyprpanel.overlay
      inputs.nur.overlays.default
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [
        "electron-11.5.0"
      ];
    };
  };

  nix.settings = {
    substituters = [
      "https://cache.garnix.io"
      "https://hyprland.cachix.org"
      "https://attic.xuyh0120.win/lantian"
      "https://walker.cachix.org"
      "https://walker-git.cachix.org"
      "https://cache.nixos.org"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cosmic.cachix.org/"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
    experimental-features = ["nix-command" "flakes"];
  };
}
