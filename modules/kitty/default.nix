{...}: let
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
in {
  programs.kitty = {
    enable = true;
    settings =
      {
        font_family = "Recursive";
        font_size = 11.5;
        cursor_shape = "beam";
        cursor_shape_unfocused = "hollow";
        cursor_trail = 1;
        background_opacity = "0.85";
        tab_bar_min_tabs = 1;
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
        wayland_titlebar_color = "system";
        macos_titlebar_color = "system";
      }
      // catppuccin-mocha;
  };
}
