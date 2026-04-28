{ colors, fonts, ... }:

{
  home.file.".config/wofi/config".text = ''
    width=280
    height=100%
    location=left
    xoffset=0
    yoffset=0
    show=drun
    prompt=Apps
    no_actions=true
    insensitive=true
    hide_scroll=true
    matching=fuzzy
  '';

  home.file.".config/wofi/style.css".text = ''
    window {
      background-color: #${colors.bg};
      border-right: 1px solid #${colors.redsoft};
      font-family: "${fonts.mono}";
      font-size: ${toString fonts.sizeSm}px;
    }

    #input {
      background-color: #${colors.bg};
      color: #${colors.fg2};
      border: none;
      border-bottom: 1px solid #${colors.bg2};
      border-radius: 0;
      padding: 10px 14px;
      margin: 0;
      outline: none;
      box-shadow: none;
    }

    #input:focus {
      border-bottom: 1px solid #${colors.redsoft};
      color: #${colors.fg};
    }

    #scroll {
      margin: 0;
      padding: 0;
    }

    #inner-box {
      background-color: transparent;
    }

    #outer-box {
      background-color: transparent;
      padding: 0;
      margin: 0;
    }

    #entry {
      padding: 9px 14px;
      border-radius: 0;
      border-left: 2px solid transparent;
      background-color: transparent;
    }

    #entry:selected {
      background-color: #${colors.bg1};
      border-left: 2px solid #${colors.redsoft};
    }

    #text {
      color: #${colors.fg2};
    }

    #entry:selected #text {
      color: #${colors.fg};
    }
  '';
}