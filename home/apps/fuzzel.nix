{ colors, ... }:

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
      colors = {
        background     = "${colors.bg}ee";
        text           = "e8f2fcff";
        match          = "${colors.fg1}ff";
        selection      = "${colors.bg2}ff";
        selection-text = "e8f2fcff";
        selection-match = "${colors.fg1}ff";
        border         = "${colors.redsoft}ff";
      };
      border = { width = 1; radius = 0; };
    };
  };
}