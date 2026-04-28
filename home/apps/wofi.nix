{ colors, fonts, ... }:

{
  home.file.".config/wofi/style.css".text = ''
    window {
      background-color: #${colors.bg};
      border-right: 2px solid #${colors.redsoft};
    }

    #input {
      background-color: #${colors.bg1};
      color: #${colors.fg};
      border: none;
      border-bottom: 1px solid #${colors.redsoft};
      border-radius: 0;
      padding: 10px 14px;
      font-family: "${fonts.mono}";
      font-size: ${toString fonts.sizeSm}px;
      margin: 0;
    }

    #input:focus {
      border-bottom: 1px solid #${colors.accent};
      box-shadow: none;
    }

    #scroll { margin: 0; }

    #inner-box { background-color: transparent; }

    #outer-box {
      background-color: transparent;
      padding: 0;
      margin: 0;
    }

    #entry {
      padding: 8px 14px;
      border-radius: 0;
      color: #${colors.fg2};
      font-family: "${fonts.mono}";
      font-size: ${toString fonts.sizeSm}px;
      border-left: 3px solid transparent;
    }

    #entry:selected {
      background-color: #${colors.bg2};
      color: #${colors.fg};
      border-left: 3px solid #${colors.accent};
    }

    #entry:hover {
      background-color: #${colors.bg1};
      color: #${colors.fg1};
    }

    #text { color: inherit; }

    #img { margin-right: 8px; }
  '';
}