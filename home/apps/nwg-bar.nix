{ colors, ... }:

{
  home.file.".config/nwg-bar/bar.json".text = ''
    [
      {
        "label": "terminal",
        "exec": "alacritty",
        "icon": "utilities-terminal"
      },
      {
        "label": "browser",
        "exec": "google-chrome-stable",
        "icon": "google-chrome"
      },
      {
        "label": "editor",
        "exec": "zeditor",
        "icon": "zed"
      },
      {
        "label": "discord",
        "exec": "vesktop",
        "icon": "vesktop"
      },
      {
        "label": "files",
        "exec": "nautilus",
        "icon": "org.gnome.Nautilus"
      },
      {
        "label": "separator",
        "exec": "",
        "icon": ""
      },
      {
        "label": "lock",
        "exec": "swaylock -f -c ${colors.bg}",
        "icon": "system-lock-screen"
      },
      {
        "label": "suspend",
        "exec": "systemctl suspend",
        "icon": "system-suspend"
      },
      {
        "label": "shutdown",
        "exec": "systemctl shutdown",
        "icon": "system-shutdown"
      }
    ]
    window {
      background-color: rgba(40, 40, 40, 0.92);
      border-right: 1px solid #504945;
    }
  
    button {
      background-color: transparent;
      color: #d5c4a1;
      border: none;
      border-radius: 0;
      padding: 12px 20px;
      font-size: 12px;
    }
  
    button:hover {
      background-color: #504945;
      color: #ebdbb2;
    }
  
    button image {
      padding-bottom: 6px;
    }
  '';
}
