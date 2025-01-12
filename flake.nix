{
  description = "Hank's nix configuration for both NixOS & macOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    # macos
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # home manager for managing user config
    home-manager = {
      url = "github:nix-community/home-manager/master";

      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the 1inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different version of nixpkgs denpendencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # build helix from source, just for fun
    helix.url = "github:helix-editor/helix/master";
    # kvim.url = "github:HCHogan/kvim/master";
  };

  outputs = inputs@{ nixpkgs, home-manager, ...}: {
    nixosConfigurations."6800u" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs;};
      modules = [
        ./configuration.nix

	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.hank = import ./home.nix;
	  home-manager.extraSpecialArgs = inputs;
	}
      ];
    };
  };
}
