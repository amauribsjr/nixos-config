{ ... }:

{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=11";
        terminal = "alacritty";
        layer = "overlay";
        prompt = "❯ ";
        width = 35;
        lines = 8;
        horizontal-pad = 16;
        vertical-pad = 12;
        inner-pad = 8;
        line-height = 22;
      };

      # ─── darkSEA (RRGGBBAA) ─────────────────────────────────────────────
      colors = {
        background      = "1b2430ee";
        text            = "d6e9ffff";
        match           = "34febbff";
        selection       = "2a3a4eff";
        selection-text  = "d6e9ffff";
        selection-match = "34febbff";
        border          = "34febbff";
      };

      border = {
        width = 1;
        radius = 6;
      };
    };
  };
}
