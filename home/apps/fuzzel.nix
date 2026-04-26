{ ... }:

{
  # Fuzzel — launcher Wayland-nativo recomendado oficialmente pelo niri.
  # Mais leve que rofi, com integração layer-shell perfeita.
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

      # Tema Gruvbox Soft Dark (mesma paleta do waybar/niri/alacritty).
      # Cores em hex+alpha (RRGGBBAA), formato exigido pelo fuzzel.
      colors = {
        background       = "32302fee";
        text             = "e8f2fcff";
        match            = "d65d0eff";
        selection        = "504945ff";
        selection-text   = "e8f2fcff";
        selection-match  = "d65d0eff";
        border           = "d65d0eff";
      };

      border = {
        width = 1;
        radius = 6;
      };
    };
  };
}
