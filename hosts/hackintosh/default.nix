{
  inputs,
  pkgs,
  hostname,
  ...
}: {
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  imports = [
    ../../modules/aerospace
    ../../modules/nerdfonts
  ];
  system.stateVersion = 5;

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    dock.wvous-tl-corner = 5;
    dock.wvous-bl-corner = 14;
    dock.orientation = "bottom";
    dock.magnification = false;
    dock.scroll-to-open = true;
    dock.tilesize = 48;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };

  nixpkgs.hostPlatform = "x86_64-darwin";
  # environment.systemPackages = with pkgs; [
  # ];

  # host-users
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;
  system.primaryUser = "hank";

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    casks = [
      "zed"
      # "orbstack"
      # "kitty"
      # "goldendict"
    ];
  };

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    package = pkgs.postgresql_17;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
    settings.timezone = "UTC";
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      autostart = true;
      address = ["10.0.0.62/24"];
      listenPort = 50722;
      privateKeyFile = "/Users/hank/Documents/privatekey";
      peers = [
        {
          publicKey = "i9ZU3WdqNxUyqtaM9F8Rbrs4ophdNpQ6wZeO/bV/jjQ=";
          presharedKeyFile = "/Users/hank/Documents/presharedkey";
          allowedIPs = ["10.0.0.0/24"];
          endpoint = "sh.imdomestic.com:50722";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
