# This module is used in home-manager
{
  inputs,
  pkgs,
  hostname,
  ...
}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];
  programs.hyprpanel = {
    enable = true;
    theme = "catppuccin_mocha";
    settings = {
      theme.font.size = "15";
      bar = {
        launcher.autoDetectIcon = true;
        workspaces = {
          show_icons = true;
          monitorSpecific = false;
        };
        clock = {
          format = "%I:%M";
          icon = "";
        };
      };
      theme.bar = {
        transparent = false;
        outer_spacing = "0.2em";
      };
      menus.dashboard.shortcuts.left.shortcut1.command = "zen";
      menus.dashboard.shortcuts.left.shortcut2.command = "spotify";
      menus.dashboard.shortcuts.left.shortcut4.icon = "";
      menus.dashboard.shortcuts.left.shortcut4.command = "nautilus";
      menus.clock = {
        time = {
          military = true;
        };
        weather.unit = "metric";
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = [
        "/home/hank/wallpapers/nixos-stroke-4k.png"
        "/home/hank/wallpapers/nixos-blue-4k.png"
      ];

      wallpaper =
        if hostname == "6800u"
        then [
          "DP-2,/home/hank/wallpapers/nixos-blue-4k.png"
          "eDP-1,/home/hank/wallpapers/nixos-blue-4k.png"
        ]
        else if hostname == "H610"
        then [
          "DP-2,/home/hank/wallpapers/nixos-stroke-4k.png"
        ]
        else [
        ];
    };
  };
  home.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    hyprcursor.enable = true;
  };
  home.packages = with pkgs; [
    hyprpanel
  ];
  wayland.windowManager.hyprland.systemd.variables = ["--all"];
  wayland.windowManager.hyprland = {
    enable = true; # enable Hyprland
    xwayland.enable = true;
    settings = {
      general = {
        border_size = 0;
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
          enabled = false;
          ignore_window = true;
          offset = "2 2";
          range = 4;
          render_power = 2;
        };
      };
      animations = {
        enabled = false;
      };
      input = {
        sensitivity = -0.9;
        follow_mouse = 1;
        touchpad = {
          scroll_factor = 0.1;
        };
      };
      "$mod" = "SUPER";
      monitor =
        if hostname == "6800u"
        then [
          "DP-2,1920x1080@240,0x0,1"
          "eDP-1,1920x1200@60.03,1920x0,1.25"
        ]
        else if hostname == "H610"
        then [
          "DP-2,3440x1440@144,0x0,1"
        ]
        else [
        ];
      # workspace = [
      #   "1, monitor:DP-2, default:true"
      # ];
      exec-once = [
        "hyprpanel"
        "hyprctl setcursor \"Vanilla-DMZ\" 24"
        "fcitx5 -d"
        # "clash-verge"
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
          # "$mod, A, exec, killall rofi || rofi -show drun -theme ~/.config/rofi/config.rasi"
          "$mod, A, exec, killall tofi-drun || tofi-drun --drun-launch=true"
          "$mod, P, exec, pavucontrol"
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
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
