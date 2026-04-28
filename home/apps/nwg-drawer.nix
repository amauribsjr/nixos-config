{ colors, fonts, ... }:

{
  home.file.".config/nwg-drawer/style.css".text = ''
    window {
      background-color: alpha(#${colors.bg}, 0.95);
      border-right: 2px solid #${colors.redsoft};
    }

    #searchbox {
      background-color: #${colors.bg1};
      color: #${colors.fg};
      border: none;
      border-bottom: 1px solid #${colors.redsoft};
      border-radius: 0;
      padding: 8px 12px;
      margin: 0;
      font-family: "${fonts.mono}";
      font-size: ${toString fonts.sizeSm}px;
    }

    #searchbox:focus {
      border-bottom: 1px solid #${colors.accent};
    }

    #grid-box {
      padding: 8px 4px;
    }

    button {
      background-color: transparent;
      border: none;
      border-radius: 0;
      padding: 8px;
      margin: 2px;
    }

    button:hover {
      background-color: #${colors.bg2};
    }

    button:focus {
      background-color: #${colors.bg2};
      border-left: 2px solid #${colors.accent};
    }

    image {
      padding-bottom: 4px;
    }

    label {
      color: #${colors.fg1};
      font-family: "${fonts.mono}";
      font-size: ${toString fonts.sizeSm}px;
    }
  '';
}
