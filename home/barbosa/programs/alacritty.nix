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
        # Catppuccin Mocha Palette
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        cursor = {
          text = "#1e1e2e";
          cursor = "#f5e0dc"; # Rosewater
        };
        selection = {
          text = "#1e1e2e";
          background = "#f5e0dc"; # Rosewater
        };
        normal = {
          black = "#45475a";   # Surface1
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";   # Subtext1
        };
        bright = {
          black = "#585b70";   # Surface2
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#a6adc8";   # Subtext0
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
