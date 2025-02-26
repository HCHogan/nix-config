{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "hank";

  networking.hostName = "wsl";
  networking.proxy.default = "http://127.0.0.1:7897";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  system.stateVersion = "24.11";
}
