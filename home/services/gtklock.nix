{ pkgs, colors, fonts, config, ... }:

let
  wallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/wallpaper.png";
in
{
  home.packages = with pkgs; [
    gtklock
  ];

  xdg.configFile."gtklock/config.ini".text = ''
    [main]
    gtk-theme=Gruvbox-Dark
    style=${config.xdg.configHome}/gtklock/style.css
    background=${wallpaper}
    time-format=%H:%M
    date-format=%A, %d %B
    idle-hide=true
    idle-timeout=5
  '';

  xdg.configFile."gtklock/style.css".text = ''
    * {
      font-family: "${fonts.mono}";
      text-shadow: none;
      box-shadow: none;
    }

    window {
      background-color: #${colors.bg};
      background-image: url("${wallpaper}");
      background-size: cover;
      background-repeat: no-repeat;
      background-position: center;
      color: #${colors.fg};
    }

    #window-box {
      background-color: #${colors.bg1};
      border: 2px solid #${colors.accent};
      border-radius: 4px;
      padding: 36px 48px;
      min-width: 420px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.65);
    }

    #clock-label {
      color: #${colors.byellow};
      font-size: 32px;
      font-weight: 700;
      margin-bottom: 8px;
    }

    #date-label {
      color: #${colors.fg2};
      font-size: 13px;
      margin-bottom: 24px;
    }

    #input-label {
      color: #${colors.bgreen};
      font-size: 12px;
      font-weight: 600;
      margin-bottom: 6px;
    }

    #input-field {
      background-color: #${colors.bg};
      color: #${colors.fg};
      border: 1px solid #${colors.bg3};
      border-radius: 4px;
      padding: 10px 14px;
      caret-color: #${colors.accent};
      box-shadow: none;
      outline: none;
    }

    #input-field:focus {
      border-color: #${colors.accent};
      box-shadow: 0 0 0 1px #${colors.accent};
      outline: none;
    }

    #unlock-button {
      background-color: #${colors.accent};
      color: #${colors.bg};
      border: 1px solid #${colors.accent};
      border-radius: 4px;
      padding: 10px 24px;
      font-weight: 800;
      box-shadow: none;
      text-shadow: none;
      outline: none;
    }

    #unlock-button:hover {
      background-color: #${colors.byellow};
      border-color: #${colors.byellow};
      color: #${colors.bg};
    }

    #error-label {
      color: #${colors.bred};
      font-weight: 600;
      margin-top: 8px;
    }
  '';
}