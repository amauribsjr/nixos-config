{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.96;
        padding = {
          x = 12;
          y = 12;
        };
        decorations = "none";
        startup_mode = "Windowed";
      };

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
        };
        size = 12.0;
      };

      colors = {
        primary = {
          background = "#32302f";
          foreground = "#ebdbb2";
        };
        cursor = {
          text = "#32302f";
          cursor = "#ebdbb2";
        };
        selection = {
          text = "#ebdbb2";
          background = "#504945";
        };
        normal = {
          black = "#32302f";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };
        bright = {
          black = "#928374";
          red = "#fb4934";
          green = "#b8bb26";
          yellow = "#fabd2f";
          blue = "#83a598";
          magenta = "#d3869b";
          cyan = "#8ec07c";
          white = "#ebdbb2";
        };
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
        unfocused_hollow = true;
      };

      selection = {
        save_to_clipboard = true;
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };
    };
  };
}
