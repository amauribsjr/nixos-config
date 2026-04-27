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

      colors = {
        background       = "32302fee";
        text             = "e8f2fcff";
        match            = "d5c4a1ff";
        selection        = "504945ff";
        selection-text   = "e8f2fcff";
        selection-match  = "d5c4a1ff";
        border           = "d65d0eff";
      };

      border = {
        width = 1;
        radius = 0;
      };
    };
  };
}
