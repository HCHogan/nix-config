{ inputs, pkgs, ... }:

{
  services.mihomo = {
    enable = true;
    webui = pkgs.metacubexd;
    configFile = "${inputs.mihomo-config.outPath}/config.yaml";
  };
}
