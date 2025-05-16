{
  inputs,
  system ? "x86_64-linux"
}: {
  # 要为哪些用户生成 standalone HM config
  usernames,
  # 如有全局额外 modules，你也可以传进来
  modules ? [],
  # 如有全局要注入到所有 users 的 configuration attrs，也可传进来
  configuration ? {},
}: let
  # 拿到对应 platform 的 pkgs
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  # HM helper
  hm = inputs.home-manager.lib.homeManagerConfiguration;
in {
  # homeConfigurations = builtins.listToAttrs (
  #   map (
  #     username: let
  #       # specialArgs 会被注入到模块的 _module.args 下
  #       specialArgs = {inherit inputs system pkgs username;};
  #
  #       # import 对应的 user module
  #       userModule = import ../home/${username}.nix specialArgs;
  #     in {
  #       name = username;
  #       value = hm {
  #         inherit pkgs;
  #
  #         # 先只加载这个用户的 module，再拼全局 modules
  #         modules = [userModule] ++ modules;
  #
  #         # 把四个值注入进所有模块
  #         extraSpecialArgs = specialArgs;
  #
  #         # 如果你还想给所有用户共同注入额外的配置项
  #         configuration = configuration;
  #       };
  #     }
  #   )
  #   usernames
  # );
}
