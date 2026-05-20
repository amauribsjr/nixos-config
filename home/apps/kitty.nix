{ colors, fonts, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = fonts.terminal;
      size = fonts.terminalSize;
    };

    settings = {
      background_opacity = "1.0";
      window_padding_width = 12;
      hide_window_decorations = true;
      cursor_shape = "block";
      cursor_blink_interval = "0.5";
      scrollback_lines = 10000;
      wheel_scroll_multiplier = "3.0";
      copy_on_select = true;
      strip_trailing_spaces = "smart";

      background = "#${colors.bg}";
      foreground = "#${colors.fg}";
      cursor = "#${colors.fg}";
      cursor_text_color = "#${colors.bg}";
      selection_background = "#${colors.bg2}";
      selection_foreground = "#${colors.fg}";

      color0 = "#${colors.black}";
      color1 = "#${colors.red}";
      color2 = "#${colors.green}";
      color3 = "#${colors.yellow}";
      color4 = "#${colors.blue}";
      color5 = "#${colors.magenta}";
      color6 = "#${colors.cyan}";
      color7 = "#${colors.white}";
      color8  = "#${colors.bblack}";
      color9  = "#${colors.bred}";
      color10 = "#${colors.bgreen}";
      color11 = "#${colors.byellow}";
      color12 = "#${colors.bblue}";
      color13 = "#${colors.bmagenta}";
      color14 = "#${colors.bcyan}";
      color15 = "#${colors.bwhite}";
    };
  };
}