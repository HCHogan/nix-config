{
  description = "Hank's nix configuration for both NixOS & macOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # macos
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    # home manager for managing user config
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

    kvim = {
      url = "github:HCHogan/kvim";
      flake = false;
    };

    wezterm-config = {
      url = "github:HCHogan/wezterm";
      flake = false;
    };

    zsh-config = {
      url = "github:HCHogan/zsh";
      flake = false;
    };

    grub-catppuccin = {
      url = "github:catppuccin/grub";
      flake = false;
    };

    dae-config = {
      url = "git+ssh://git@github.com/HCHogan/dae";
      flake = false;
    };

    mihomo-config = {
      url = "git+ssh://git@github.com/HCHogan/mihomo-config";
      flake = false;
    };

    nur-xddxdd = {
      url = "github:xddxdd/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    daeuniverse.url = "github:daeuniverse/flake.nix";
  };

  outputs = inputs
  : let
    mkConfigurations = (import ./lib/mkConfigurations.nix) {inherit inputs;};
  in
    mkConfigurations {
      configurations = [
        {
          hostname = "H610";
          usernames = ["hank" "genisys"];
          system = "x86_64-linux";
          extraModules = [
            inputs.nur-xddxdd.nixosModules.setupOverlay
            inputs.daeuniverse.nixosModules.dae
            inputs.daeuniverse.nixosModules.daed
          ];
        }
        {
          hostname = "6800u";
          usernames = ["hank"];
          system = "x86_64-linux";
          extraModules = [
            # nixos-cosmic.nixosModules.default
            inputs.nur-xddxdd.nixosModules.setupOverlay
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen4
            inputs.daeuniverse.nixosModules.dae
            inputs.daeuniverse.nixosModules.daed
          ];
        }
        {
          hostname = "m3max";
          usernames = ["hank"];
          system = "aarch64-darwin";
        }
      ];
    };
}
