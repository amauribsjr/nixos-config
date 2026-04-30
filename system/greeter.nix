{ pkgs, colors, fonts, ... }:

{
  programs.regreet = {
    enable = true;

    settings = {
      GTK = {
        application_prefer_dark_theme = true;
        font_name                     = "${fonts.mono} 13";
        cursor_theme_name             = "Bibata-Modern-Classic";
      };
    };

    css = ''
      window {
        background-color: #${colors.bg};
      }

      box#login-box {
        background-color: #${colors.bg1};
        border:           1px solid #${colors.bg2};
        padding:          36px 48px;
        min-width:        300px;
      }

      label {
        color: #${colors.fg};
      }

      label#clock {
        color:         #${colors.fg2};
        font-size:     13px;
        margin-bottom: 20px;
      }

      entry {
        background-color: #${colors.bg};
        color:            #${colors.fg};
        border:           1px solid #${colors.bg2};
        border-radius:    0;
        box-shadow:       none;
        padding:          8px 12px;
        caret-color:      #${colors.fg};
      }

      entry:focus {
        border-color: #${colors.fg1};
        box-shadow:   none;
      }

      button.login-button {
        background-color: #${colors.bg2};
        color:            #${colors.fg};
        border:           none;
        border-radius:    0;
        padding:          8px 20px;
      }

      button.login-button:hover {
        background-color: #${colors.bg3};
      }

      combobox button,
      dropdown > button {
        background-color: #${colors.bg};
        color:            #${colors.fg};
        border:           1px solid #${colors.bg2};
        border-radius:    0;
        box-shadow:       none;
      }
    '';
  };

  security.pam.services.greetd.enableGnomeKeyring = true;

  environment.systemPackages = [ pkgs.bibata-cursors ];
}