{ colors, fonts, ... }:

{
  home.file.".config/wofi/config".text = ''
    no_actions=true
    insensitive=true
    hide_scroll=true
    matching=fuzzy
    allow_images=false
    allow_markup=false
    layer=top
  '';

  home.file.".config/wofi/center.css".text = ''
    window {
      background-color: #${colors.bg};
      font-family: "${fonts.mono}";
      border: 1px solid #${colors.fg1};
    }

    #input {
      background-color: #${colors.bg};
      color: #${colors.fg2};
      border: none;
      border-bottom: 1px solid #${colors.bg2};
      border-radius: 0;
      padding: 12px 20px;
      margin: 0;
      outline: none;
      box-shadow: none;
      font-size: 14px;
    }

    #input:focus {
      color: #${colors.fg};
      border-bottom: 1px solid #${colors.fg1};
    }

    #scroll { margin: 0; padding: 0; }
    #inner-box { background-color: transparent; }
    #outer-box { background-color: transparent; padding: 0; margin: 0; }

    #entry {
      padding: 10px 20px;
      border-radius: 0;
      background-color: transparent;
    }

    #entry:selected {
      background-color: #${colors.bg1};
    }

    #text {
      color: #${colors.fg2};
      font-size: 14px;
    }

    #entry:selected #text {
      color: #${colors.fg};
    }
  '';
}
