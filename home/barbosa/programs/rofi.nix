{ ... }:

{
  programs.rofi = {
    enable = true;
    theme = "catppuccin-mocha";

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      display-drun = "Applications";
      display-run = "Run";
      display-window = "Windows";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";
      font = "JetBrainsMono Nerd Font 12";

      # Layout
      lines = 10;
      columns = 1;
      width = 35;
      location = 0;
      padding = 10;

      disable-history = false;
      hide-scrollbar = true;
      sidebar-mode = false;
      terminal = "alacritty";
    };
  };

  home.file.".config/rofi/catppuccin-mocha.rasi".text = ''
    * {
        /* Catppuccin Mocha colors */
        bg:                   #1e1e2e;
        bg-alt:               #313244; /* Surface0 */
        fg:                   #cdd6f4;
        fg-alt:               #a6adc8; /* Subtext0 */

        red:                  #f38ba8;
        green:                #a6e3a1;
        yellow:               #f9e2af;
        blue:                 #89b4fa;
        purple:               #cba6f7; /* Mauve */
        aqua:                 #94e2d5; /* Teal */
        orange:               #fab387; /* Peach */
        gray:                 #6c7086; /* Overlay0 */

        background-color:     @bg;
        text-color:           @fg;

        border-color:         @purple;
        selected-bg:          @bg-alt;
        selected-fg:          @purple;
        urgent-bg:            @red;
        urgent-fg:            @bg;
        active-bg:            @green;
        active-fg:            @bg;
    }

    window {
        transparency:         "real";
        background-color:     @bg;
        border:               2px;
        border-color:         @border-color;
        border-radius:        0px;
        padding:              0px;
        width:                600px;
    }

    mainbox {
        border:               0;
        padding:              0;
        background-color:     transparent;
    }

    message {
        border:               0;
        border-color:         @border-color;
        padding:              10px;
        background-color:     @bg-alt;
    }

    textbox {
        text-color:           @fg;
        background-color:     transparent;
    }

    inputbar {
        children:             [ prompt, textbox-prompt-colon, entry, case-indicator ];
        background-color:     @bg-alt;
        text-color:           @fg;
        spacing:              0;
        padding:              15px;
        border:               0 0 2px 0;
        border-color:         @border-color;
    }

    prompt {
        spacing:              0;
        text-color:           @purple;
        background-color:     transparent;
        padding:              0 10px 0 0;
    }

    textbox-prompt-colon {
        expand:               false;
        str:                  "›";
        text-color:           @purple;
        background-color:     transparent;
        padding:              0 5px 0 0;
    }

    entry {
        spacing:              0;
        text-color:           @fg;
        background-color:     transparent;
        placeholder-color:    @gray;
        placeholder:          "Type to search...";
    }

    case-indicator {
        spacing:              0;
        text-color:           @fg-alt;
        background-color:     transparent;
    }

    listview {
        fixed-height:         true;
        border:               0;
        spacing:              5px;
        scrollbar:            false;
        padding:              10px;
        background-color:     transparent;
        lines:                10;
    }

    element {
        border:               0;
        padding:              12px 15px;
        background-color:     transparent;
        text-color:           @fg;
        border-radius:        0px;
    }

    element normal.normal {
        background-color:     transparent;
        text-color:           @fg;
    }

    element normal.urgent {
        background-color:     @urgent-bg;
        text-color:           @urgent-fg;
    }

    element normal.active {
        background-color:     @active-bg;
        text-color:           @active-fg;
    }

    element selected.normal {
        background-color:     @selected-bg;
        text-color:           @selected-fg;
        border:               0 0 0 3px;
        border-color:         @purple;
    }

    element selected.urgent {
        background-color:     @urgent-bg;
        text-color:           @bg;
    }

    element selected.active {
        background-color:     @active-bg;
        text-color:           @bg;
    }

    element-icon {
        background-color:     transparent;
        size:                 24px;
        padding:              0 10px 0 0;
    }

    element-text {
        background-color:     transparent;
        text-color:           inherit;
        vertical-align:       0.5;
    }

    scrollbar {
        width:                4px;
        border:               0;
        handle-width:         8px;
        padding:              0;
        handle-color:         @gray;
        background-color:     @bg-alt;
    }

    mode-switcher {
        border:               2px 0 0;
        border-color:         @border-color;
    }

    button {
        spacing:              0;
        text-color:           @fg-alt;
        background-color:     @bg-alt;
        padding:              10px;
    }

    button selected {
        background-color:     @selected-bg;
        text-color:           @selected-fg;
    }

    error-message {
        border:               2px;
        border-color:         @red;
        padding:              10px;
        background-color:     @bg;
        text-color:           @red;
    }
  '';

  home.file.".config/rofi/power-menu.rasi".text = ''
    * {
        bg:                   #1e1e2e;
        bg-alt:               #313244;
        fg:                   #cdd6f4;
        yellow:               #f9e2af;
        orange:               #fab387;
        red:                  #f38ba8;
        purple:               #cba6f7;

        background-color:     @bg;
        text-color:           @fg;
    }

    window {
        transparency:         "real";
        background-color:     @bg;
        border:               2px;
        border-color:         @red;
        width:                180px;
        location:             center;
    }

    mainbox {
        padding:              0;
    }

    inputbar {
        children:             [ prompt ];
        background-color:     @bg-alt;
        padding:              8px 10px;
        border:               0 0 2px 0;
        border-color:         @red;
    }

    prompt {
        text-color:           @red;
    }

    listview {
        spacing:              0;
        padding:              3px 0;
        lines:                4;
    }

    element {
        padding:              8px 12px;
        background-color:     transparent;
        text-color:           @fg;
    }

    element selected.normal {
        background-color:     @bg-alt;
        text-color:           @red;
        border:               0 0 0 3px;
        border-color:         @red;
    }

    element-text {
        background-color:     transparent;
        text-color:           inherit;
    }
  '';
}
