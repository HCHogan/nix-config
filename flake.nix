{
  description = "Hank's nix configuration for both NixOS & macOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    # macos
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home manager for managing user config
    home-manager = {
      url = "github:nix-community/home-manager/master";

      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the 1inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different version of nixpkgs denpendencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # wezterm = {
    #   url = "github:wez/wezterm?dir=nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # }

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

    helix.url = "github:helix-editor/helix/master";
        kvim = {
      url = "github:HCHogan/kvim";
      flake = false;
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nixos-cosmic, nix-darwin, kvim, ...}: {
    # formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    # overlays = import ./overlays {inherit inputs;};
    nixosConfigurations = {
      "6800u" = let 
        username = "hank";
        hostname = "6800u";
        system = "x86_64-linux";
        specialArgs = inputs // {
          inherit username hostname;
        };
      in
      nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default
          ./hosts/6800u
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs // {
              kvim = kvim.outPath;
            };
            home-manager.users.${username} = import ./home/linux/home.nix;
          }
        ];
      };
    };

    darwinConfigurations = {
      "m3max" = let
        username = "hank";
        hostname = "m3max";
        system = "aarch64-darwin";
        specialArgs = inputs // {
          inherit username hostname;
        };
      in
      nix-darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [ 
          ./hosts/m3max
          # home manager
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs // {
              kvim = kvim.outPath;
            };
            home-manager.users.${username} = import ./home/darwin/home.nix;
          }
        ];
      };
    };
  };
}
