# This module is used in home-manager
{ inputs, config, pkgs, ... }:

let 
  hostname = builtins.getEnv "HOSTNAME";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = [
        "/home/hank/wallpapers/nixos-stroke-4k.png"
      ];

      wallpaper = if hostname == "6800u" then [
        "DP-2,/home/hank/wallpapers/nixos-stroke-4k.png"
        "eDP-1,/home/hank/wallpapers/nixos-stroke-4k.png"
      ] else if hostname == "H610" then [
        "DP-2,/home/hank/wallpapers/nixos-stroke-4k.png"
      ] else [
      ];
    };
  };
  home.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    hyprcursor.enable = true;
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
        sensitivity = -0.9;
        follow_mouse = 1;
      };
      "$mod" = "SUPER";
      monitor = if hostname == "6800u" then [
        "DP-2,1920x1080@240,0x0,1"
        "eDP-1,1920x1200@60.03,1920x0,1.25"
      ] else if hostname == "H610" then [
        "DP-2,3440x1440@144,0x0,1"
      ] else [

      ];
      # workspace = [
      #   "1, monitor:DP-2, default:true"
      # ];
      exec-once = [
        "waybar"
        "hyprctl setcursor \"Vanilla-DMZ\" 24"
        "fcitx5 -d"
        "clash-verge"
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
          "$mod SHIFT, S, exec, grimblast copy area"
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
          "$mod, P, exec, pavucontrol"
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"
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
    extraConfig = ''
      device {
          name = syna8019:00-06cb:ce68-touchpad
          sensitivity = -0
          natural_scroll = true
      }
      device {
          name = ninjutso-ninjutso-sora-v2-mouse
          sensitivity = -0.9
      }
    '';
  };
}
