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
        background = "32302fee";       # bg0_s + 93% alpha
        text = "d5c4a1ff";             # fg0
        match = "8ec07cff";             # aqua (highlight do match na lista)
        selection = "504945ff";         # bg2 (background do item selecionado)
        selection-text = "fbf1c7ff";   # fg
        selection-match = "8ec07cff";  # aqua (match dentro do item selecionado)
        border = "8ec07cff";            # aqua
      };

      border = {
        width = 1;
        radius = 6;
      };
    };
  };
}
