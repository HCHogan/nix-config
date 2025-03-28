{
  pkgs,
  system,
  ...
}: let
  catppuccin-mocha = {
    foreground = "#cdd6f4";
    background = "#1d1e2e";
    selection_foreground = "#1e1e2e";
    selection_background = "#f5e0dc";
    cursor = "#f5e0dc";
    cursor_text_color = "#1e1e2e";
    url_color = "#f5e0dc";
    active_border_color = "#b4befe";
    inactive_border_color = "#6c7086";
    bell_border_color = "#f9e2af";
    active_tab_foreground = "#11111b";
    active_tab_background = "#cba6f7";
    inactive_tab_foreground = "#cdd6f4";
    inactive_tab_background = "#181825";
    tab_bar_background = "#11111b";
    mark1_foreground = "#1e1e2e";
    mark1_background = "#b4befe";
    mark2_foreground = "#1e1e2e";
    mark2_background = "#cba6f7";
    mark3_foreground = "#1e1e2e";
    mark3_background = "#74c7ec";
    color0 = "#45475a";
    color8 = "#585b70";
    color1 = "#f38ba8";
    color9 = "#f38ba8";
    color2 = "#a6e3a1";
    color10 = "#a6e3a1";
    color3 = "#f9e2af";
    color11 = "#f9e2af";
    color4 = "#89b4fa";
    color12 = "#89b4fa";
    color5 = "#f5c2e7";
    color13 = "#f5c2e7";
    color6 = "#94e2d5";
    color14 = "#94e2d5";
    color7 = "#bac2de";
    color15 = "#a6adc8";
  };
  lib = pkgs.lib;
  isLinux = lib.hasInfix "linux" system;
in {
  programs.kitty = {
    enable = true;
    font.name = if isLinux then "Recursive" else "FiraCode Nerd Font Mono";
    shellIntegration.enableZshIntegration = true;
    settings =
      {
        # font_family = "Recursive";
        font_size =
          if isLinux
          then 11.5
          else 15;
        cursor_shape = "beam";
        cursor_shape_unfocused = "hollow";
        cursor_trail = 1;
        background_opacity = "0.85";
        background_blur =
          if isLinux
          then 0
          else 5;
        hide_window_decorations = true;
        tab_bar_min_tabs = 1;
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
        wayland_titlebar_color = "system";
        macos_titlebar_color = "system";
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
      // catppuccin-mocha;
  };
}
