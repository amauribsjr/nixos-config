{ colors, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.96;
        padding = { x = 12; y = 12; };
        decorations = "none";
        startup_mode = "Windowed";
      };

      font = {
        normal  = { family = "JetBrainsMono Nerd Font"; };
        bold    = { family = "JetBrainsMono Nerd Font"; };
        italic  = { family = "JetBrainsMono Nerd Font"; };
        size = 12.0;
      };

      colors = {
        primary = {
          background = "#${colors.bg}";
          foreground = "#${colors.fg}";
        };
        cursor = {
          text   = "#${colors.bg}";
          cursor = "#${colors.fg}";
        };
        selection = {
          text       = "#${colors.fg}";
          background = "#${colors.bg2}";
        };
        normal = {
          black   = "#${colors.black}";
          red     = "#${colors.red}";
          green   = "#${colors.green}";
          yellow  = "#${colors.yellow}";
          blue    = "#${colors.blue}";
          magenta = "#${colors.magenta}";
          cyan    = "#${colors.cyan}";
          white   = "#${colors.white}";
        };
        bright = {
          black   = "#${colors.bblack}";
          red     = "#${colors.bred}";
          green   = "#${colors.bgreen}";
          yellow  = "#${colors.byellow}";
          blue    = "#${colors.bblue}";
          magenta = "#${colors.bmagenta}";
          cyan    = "#${colors.bcyan}";
          white   = "#${colors.bwhite}";
        };
      };

      cursor = {
        style = { shape = "Block"; blinking = "On"; };
        unfocused_hollow = true;
      };
      selection.save_to_clipboard = true;
      scrolling = { history = 10000; multiplier = 3; };
    };
  };
}