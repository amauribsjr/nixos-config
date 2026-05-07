{ colors, fonts, theme, ... }:

let
  gtkTheme = theme.gtk;
  cursor = theme.cursor;
  cursorPkg = theme.cursor.package;
in

{
  programs.regreet = {
    enable = true;

    font = {
      name    = fonts.ui;
      size    = 13;
      package = theme.fontPackages.ui;
    };

    theme = {
      inherit (gtkTheme) name package;
    };

    cursorTheme = {
      inherit (cursor) name package;
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

      * {
        font-family: "${fonts.ui}";
        text-shadow: none;
        box-shadow: none;
      }

      window {
        background-color: #${colors.bg};
        color: #${colors.fg};
      }

      box#login-box {
        background-color: #${colors.bg1};
        border: 2px solid #${colors.accent};
        border-radius: 4px;
        padding: 36px 48px;
        min-width: 420px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.65);
      }

      label {
        color: #${colors.fg};
        font-weight: 500;
      }

      label#clock {
        color: #${colors.byellow};
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 28px;
      }

      label.user-label,
      label.session-label {
        color: #${colors.bgreen};
        font-size: 12px;
        font-weight: 600;
        margin-top: 10px;
        margin-bottom: 6px;
      }

      entry,
      combobox button,
      dropdown > button {
        background-color: #${colors.bg};
        background-image: none;
        color: #${colors.fg};
        border: 1px solid #${colors.bg3};
        border-radius: 4px;
        padding: 10px 14px;
        box-shadow: none;
        outline: none;
      }

      entry {
        caret-color: #${colors.accent};
      }

      entry:focus,
      entry:focus-within,
      combobox button:focus,
      dropdown > button:focus {
        border-color: #${colors.accent};
        box-shadow: 0 0 0 1px #${colors.accent};
        outline: none;
      }

      entry selection {
        background-color: #${colors.accent};
        color: #${colors.bg};
      }

      combobox button:hover,
      dropdown > button:hover {
        border-color: #${colors.accent};
      }

      combobox window,
      dropdown popover,
      popover {
        background-color: #${colors.bg1};
        color: #${colors.fg};
        border: 1px solid #${colors.bg3};
      }

      popover contents,
      list,
      row {
        background-color: #${colors.bg1};
        color: #${colors.fg};
      }

      row:hover,
      row:selected {
        background-color: #${colors.bg2};
        color: #${colors.fg};
      }

      button {
        background-color: #${colors.bg2};
        background-image: none;
        color: #${colors.fg};
        border: 1px solid #${colors.bg3};
        border-radius: 4px;
        padding: 10px 24px;
        font-weight: 700;
        box-shadow: none;
        text-shadow: none;
        outline: none;
      }

      button:hover {
        background-color: #${colors.bg3};
        background-image: none;
        border-color: #${colors.accent};
        color: #${colors.fg};
      }

      button:focus,
      button:focus-visible {
        border-color: #${colors.accent};
        box-shadow: 0 0 0 1px #${colors.accent};
        outline: none;
      }

      button:active {
        background-color: #${colors.bg4};
        background-image: none;
      }

      button.suggested-action {
        background-color: #${colors.accent};
        background-image: none;
        color: #${colors.bg};
        border: 1px solid #${colors.accent};
        font-weight: 800;
      }

      button.suggested-action:hover {
        background-color: #${colors.byellow};
        background-image: none;
        border-color: #${colors.byellow};
        color: #${colors.bg};
      }

      button.suggested-action:active {
        background-color: #${colors.yellow};
        background-image: none;
        border-color: #${colors.yellow};
        color: #${colors.bg};
      }

      button.destructive-action {
        background-color: #${colors.red};
        background-image: none;
        color: #${colors.fg};
        border: 1px solid #${colors.red};
      }

      button.destructive-action:hover {
        background-color: #${colors.bred};
        background-image: none;
        border-color: #${colors.bred};
        color: #${colors.bg};
      }

      button.destructive-action:active {
        background-color: #${colors.redsoft};
        background-image: none;
        border-color: #${colors.redsoft};
        color: #${colors.fg};
      }

      label.error,
      label#error {
        color: #${colors.bred};
        font-weight: 600;
        margin-top: 8px;
      }
    '';
  };

  security.pam.services.greetd.enableGnomeKeyring = true;

  environment.systemPackages = [
    cursorPkg
  ];
}
