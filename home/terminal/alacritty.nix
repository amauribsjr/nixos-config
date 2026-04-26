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
          background = "#151f2e";
          foreground = "#e8f2fc";
        };

        cursor = {
          text = "#151f2e";
          cursor = "#4a9eca";
        };

        selection = {
          text = "#e8f2fc";
          background = "#253548";
        };

        normal = {
          black   = "#151f2e";
          red     = "#c0737a";
          green   = "#4a9eca";
          yellow  = "#c4a86a";
          blue    = "#c8daea";
          magenta = "#8b7eb8";
          cyan    = "#6a9e7f";
          white   = "#e8f2fc";
        };

        bright = {
          black   = "#253548";
          red     = "#c0737a";
          green   = "#4a9eca";
          yellow  = "#c4a86a";
          blue    = "#2d7aaa";
          magenta = "#8b7eb8";
          cyan    = "#253548";
          white   = "#c8daea";
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
