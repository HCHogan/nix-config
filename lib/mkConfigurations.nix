{inputs}: {configurations}: let
  pkgs = inputs.nixpkgs;
  listToAttrs = builtins.listToAttrs;
  hasInfix = pkgs.lib.hasInfix;
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
          ./../hosts/${hostname}
          home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users = pkgs.lib.genAttrs usernames (
              username:
                import (./../home + "/${username}.nix") {inherit username system inputs;}
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
