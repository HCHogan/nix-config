{ inputs, config, pkgs, ... }: 

{
  imports = [
    ../core.nix
    ../base/home.nix
  ];

  programs.kitty.enable = true; # required for the default Hyprland config
  programs.firefox.enable = true;

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = [
        "/home/hank/wallpapers/nixos-stroke-4k.png"
      ];

      wallpaper = [
        "DP-2,/home/hank/wallpapers/nixos-stroke-4k.png"
      ];
    };
  };
  wayland.windowManager.hyprland.systemd.variables = ["--all"];
  wayland.windowManager.hyprland = {
    enable = true; # enable Hyprland
    xwayland.enable = true;
    settings = {
      general = {
        border_size = 2;
        gaps_in = 5;
        gaps_out = 10;
        resize_on_border = true;
        extend_border_grab_area = 10;
      };
      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          ignore_window = true;
          offset = "2 2";
          range = 4;
          render_power = 2;
        };
      };
      animations = {
        enabled = true;
      };
      input = {
        follow_mouse = 1;
        sensitivity = -0.5;
      };
      "$mod" = "SUPER";
      monitor = [
        "DP-2,1920x1080@240,0x0,1"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
      bind =
        [
          "$mod, Q, killactive,"
          "$mod SHIFT, Q, exit,"
          "$mod, F, fullscreen"
          "$mod, Space, togglefloating"
          ", Print, exec, grimblast copy area"
          "$mod, Return, exec, wezterm"
          "$mod, I, exec, gnome-control-center"
          "$mod, E, exec, nautilus"
          "$mod, W, exec, zen"
          "$mod, left, resizeactive, -20 0"
          "$mod, right, resizeactive, 20 0"
          "$mod, up, resizeactive, 0 -20"
          "$mod, down, resizeactive, 0 20"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, A, exec, killall rofi || rofi -show drun -theme ~/.config/rofi/config.rasi"
        ]
        ++ (
          builtins.concatLists (builtins.genList (i:
              let ws = i + 1;
              in [
                "$mod, ${toString ws}, workspace, ${toString ws}"
                "$mod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
  };

  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";

}
