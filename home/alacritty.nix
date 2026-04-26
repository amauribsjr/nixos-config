{ ... }:

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

      # ─── darkSEA ────────────────────────────────────────────────────────
      colors = {
        primary = {
          background = "#1b2430";
          foreground = "#d6e9ff";
        };

        cursor = {
          text   = "#1b2430";
          cursor = "#34febb";
        };

        selection = {
          text       = "#d6e9ff";
          background = "#2a3a4e";
        };

        normal = {
          black   = "#1b2430";
          red     = "#e06b74";
          green   = "#34febb";
          yellow  = "#e5c07b";
          blue    = "#88b4e7";
          magenta = "#a77bca";
          cyan    = "#32ae85";
          white   = "#d6e9ff";
        };

        bright = {
          black   = "#444c55";
          red     = "#e06b74";
          green   = "#34febb";
          yellow  = "#e5c07b";
          blue    = "#5d8cc0";
          magenta = "#a77bca";
          cyan    = "#42675a";
          white   = "#88b4e7";
        };
      };

      cursor = {
        style = { shape = "Block"; blinking = "On"; };
        unfocused_hollow = true;
      };

      selection  = { save_to_clipboard = true; };
      scrolling  = { history = 10000; multiplier = 3; };
    };
  };
}
