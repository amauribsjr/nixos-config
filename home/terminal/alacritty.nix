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
          foreground = "#d5c4a1";
        };

        cursor = {
          text = "#32302f";
          cursor = "#d5c4a1";
        };

        selection = {
          text = "#d5c4a1";
          background = "#504945";
        };

        normal = {
          black = "#32302f";
          red = "#ea6962";
          green = "#a9b665";
          yellow = "#d8a657";
          blue = "#7daea3";
          magenta = "#d3869b";
          cyan = "#89b482";
          white = "#d5c4a1";
        };

        bright = {
          black = "#928374";
          red = "#ea6962";
          green = "#a9b665";
          yellow = "#d8a657";
          blue = "#7daea3";
          magenta = "#d3869b";
          cyan = "#89b482";
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
