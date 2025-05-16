{inputs}: {configurations}: let
  nixpkgs = inputs.nixpkgs;
  listToAttrs = builtins.listToAttrs;
  hasInfix = nixpkgs.lib.hasInfix;
  mapConfigurations = builtins.map (
    config: {
      name = config.hostname;
      value = mkConfiguration config;
    }
  );
  mkConfiguration = {
    usernames,
    hostname,
    system,
    extraModules ? [],
  }: let
    lib =
      if hasInfix "darwin" system
      then inputs.nix-darwin.lib.darwinSystem
      else inputs.nixpkgs.lib.nixosSystem;
    home-manager =
      if hasInfix "darwin" system
      then inputs.home-manager.darwinModules.home-manager
      else inputs.home-manager.nixosModules.home-manager;
    specialArgs = {inherit inputs usernames system hostname;};
  in
    lib {
      inherit specialArgs;
      modules =
        [
          ./../modules/system.nix
          ./../modules/nix.nix
          ./../hosts/${hostname}
          home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users = nixpkgs.lib.genAttrs usernames (
              username: {
                imports = [
                  (import ./../home/${username}.nix {inherit username;})
                ];
              }
            );
          }
        ]
        ++ extraModules;
    };
  nixosConfigurationList = builtins.filter (c: hasInfix "linux" c.system) configurations;
  darwinConfigurationList = builtins.filter (c: hasInfix "darwin" c.system) configurations;
in {
  nixosConfigurations = listToAttrs (mapConfigurations nixosConfigurationList);
  darwinConfigurations = listToAttrs (mapConfigurations darwinConfigurationList);
}
