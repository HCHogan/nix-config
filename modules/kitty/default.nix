{
  pkgs,
  system,
  ...
}: let
  noir = {
    background = "#121212";
    foreground = "#c6c8d1";

    selection_background = "#1e2132";
    selection_foreground = "#c6c8d1";

    cursor = "#d2d4de";

    # black
    color0 = "#121212";
    color8 = "#212121";

    # red
    color1 = "#bf616a";
    color9 = "#bf616a";

    # green
    color2 = "#a3be8c";
    color10 = "#a3be8c";

    # yellow/orange
    color3 = "#ebcb8b";
    color11 = "#ebcb8b";

    # blue
    color4 = "#8fbcbb";
    color12 = "#8fbcbb";

    # magenta/purple
    color5 = "#a093c7";
    color13 = "#ada0d3";

    # cyan
    color6 = "#47eae0";
    color14 = "#47eae0";

    # white
    color7 = "#f5f5f5";
    color15 = "#ffffff";

    # tab bar
    active_tab_foreground = "#131313";
    active_tab_background = "#a3be8c";
    inactive_tab_foreground = "#d5d5d5";
    inactive_tab_background = "#323232";
    tab_bar_background = "#131313";
  };

  lib = pkgs.lib;
  isLinux = lib.hasInfix "linux" system;
in {
  programs.kitty = {
    enable = true;
    font.name =
      if isLinux
      then "Recursive"
      else "RecMonoLinear Nerd Font Mono";
    shellIntegration.enableZshIntegration = true;
    settings =
      {
        font_size =
          if isLinux
          then 11.5
          else 15;
        cursor_shape = "beam";
        cursor_shape_unfocused = "hollow";
        cursor_trail = 1;
        cursor_blink_interval = 0;
        background_opacity = 0.85;
        background_blur =
          if isLinux
          then 0
          else 20;
        hide_window_decorations = true;
        tab_bar_min_tabs = 1;
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
        wayland_titlebar_color = "system";
        macos_titlebar_color = "system";
        macos_option_as_alt = true;
        sync_to_monitor = true;
        symbol_map = let
          mappings = [
            "U+23FB-U+23FE"
            "U+2B58"
            "U+E200-U+E2A9"
            "U+E0A0-U+E0A3"
            "U+E0B0-U+E0BF"
            "U+E0C0-U+E0C8"
            "U+E0CC-U+E0CF"
            "U+E0D0-U+E0D2"
            "U+E0D4"
            "U+E700-U+E7C5"
            "U+F000-U+F2E0"
            "U+2665"
            "U+26A1"
            "U+F400-U+F4A8"
            "U+F67C"
            "U+E000-U+E00A"
            "U+F300-U+F313"
            "U+E5FA-U+E62B"
          ];
        in
          (builtins.concatStringsSep "," mappings) + " FiraCode Nerd Font Mono";
      }
      // noir;
  };
}
