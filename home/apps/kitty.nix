{ fonts, ... }:

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
    };
  };
}