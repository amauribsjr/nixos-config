{ colors, fonts, ... }:

{
  home.file.".config/wofi/style.css".text = ''
    window {
      background-color: #${colors.bg};
      border: 1px solid #${colors.bg2};
    }

    #input {
      background-color: #${colors.bg1};
      color: #${colors.fg};
      border: none;
      border-bottom: 1px solid #${colors.bg2};
      border-radius: 0;
      padding: 8px 12px;
      font-family: "${fonts.mono}";
      font-size: ${toString fonts.sizeSm}px;
    }

    #input:focus {
      border-bottom: 1px solid #${colors.accent};
    }

    #scroll {
      margin: 4px 0;
    }

    #inner-box {
      background-color: transparent;
    }

    #outer-box {
      background-color: transparent;
      padding: 4px;
    }

    #entry {
      padding: 6px 12px;
      border-radius: 0;
      color: #${colors.fg1};
      font-family: "${fonts.mono}";
      font-size: ${toString fonts.sizeSm}px;
    }

    #entry:selected {
      background-color: #${colors.bg2};
      color: #${colors.fg};
    }

    #entry:hover {
      background-color: #${colors.bg1};
    }

    #text {
      color: inherit;
    }
  '';
}