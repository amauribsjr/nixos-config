{ pkgs, colors, fonts, ... }:

{
  programs.regreet = {
    enable = true;

    font = {
      name    = fonts.mono;
      size    = 13;
      package = pkgs.nerd-fonts.jetbrains-mono;
    };

    theme = {
      name    = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };

    cursorTheme = {
      name    = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };

    extraCss = ''

      @define-color accent_color    #${colors.accent};
      @define-color accent_bg_color #${colors.accent};
      @define-color accent_fg_color #${colors.bg};

      @define-color window_bg_color #${colors.bg};
      @define-color window_fg_color #${colors.fg};

      @define-color view_bg_color   #${colors.bg};
      @define-color view_fg_color   #${colors.fg};

      @define-color card_bg_color   #${colors.bg1};
      @define-color card_fg_color   #${colors.fg};

      @define-color popover_bg_color #${colors.bg1};
      @define-color popover_fg_color #${colors.fg};

      @define-color dialog_bg_color  #${colors.bg1};
      @define-color dialog_fg_color  #${colors.fg};

      @define-color destructive_color    #${colors.bred};
      @define-color destructive_bg_color #${colors.red};
      @define-color destructive_fg_color #${colors.fg};

      window {
        background-color: #${colors.bg};
      }

      box#login-box {
        background-color: #${colors.bg1};
        border:           2px solid #${colors.bg3};
        border-radius:    4px;
        padding:          40px 56px;
        min-width:        320px;
        box-shadow:       0 8px 24px rgba(0, 0, 0, 0.65);
      }

      label {
        color:       #${colors.fg};
        font-weight: 500;
      }

      label#clock {
        color:         #${colors.yellow};
        font-size:     16px;
        font-weight:   600;
        margin-bottom: 24px;
      }

      label.user-label,
      label.session-label {
        color:      #${colors.fg2};
        font-size:  12px;
        margin-top: 8px;
      }

      entry {
        background-color: #${colors.bg};
        color:            #${colors.fg};
        border:           1px solid #${colors.bg3};
        border-radius:    4px;
        box-shadow:       none;
        outline:          none;
        padding:          10px 14px;
        caret-color:      #${colors.accent};
        font-family:      "${fonts.mono}";
      }

      entry:focus,
      entry:focus-within {
        border-color:     #${colors.yellow};
        box-shadow:       0 0 0 1px #${colors.yellow};
      }

      entry selection {
        background-color: #${colors.accent};
        color:            #${colors.bg};
      }

      button {
        background-color: #${colors.bg2};
        color:            #${colors.fg};
        border:           1px solid #${colors.bg3};
        border-radius:    4px;
        padding:          10px 24px;
        font-weight:      700;
        box-shadow:       none;
        text-shadow:      none;
      }

      button:hover {
        background-color: #${colors.bg3};
        border-color:     #${colors.accent};
      }

      button:active {
        background-color: #${colors.bg4};
      }

      button.login-button,
      button.suggested-action {
        background-color: #${colors.green};
        color:            #${colors.bg};
        border:           1px solid #${colors.green};
      }

      button.login-button:hover,
      button.suggested-action:hover {
        background-color: #${colors.bgreen};
        border-color:     #${colors.bgreen};
      }

      button.login-button:active,
      button.suggested-action:active {
        background-color: #${colors.yellow};
        border-color:     #${colors.yellow};
      }

      button.destructive-action {
        background-color: #${colors.red};
        color:            #${colors.fg};
        border:           1px solid #${colors.red};
      }

      button.destructive-action:hover {
        background-color: #${colors.bred};
        border-color:     #${colors.bred};
      }

      combobox button,
      dropdown > button {
        background-color: #${colors.bg};
        color:            #${colors.fg};
        border:           1px solid #${colors.bg3};
        border-radius:    4px;
        box-shadow:       none;
        padding:          6px 12px;
      }

      combobox button:hover,
      dropdown > button:hover {
        border-color:     #${colors.accent};
      }

      combobox window,
      dropdown popover {
        background-color: #${colors.bg1};
        border:           1px solid #${colors.bg3};
      }

      label.error,
      label#error {
        color:       #${colors.bred};
        font-weight: 600;
      }
    '';
  };

  security.pam.services.greetd.enableGnomeKeyring = true;

  environment.systemPackages = [ pkgs.bibata-cursors ];
}
