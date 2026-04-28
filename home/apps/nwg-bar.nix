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
        "exec": "systemctl poweroff",
        "icon": "system-shutdown"
      }
    ]
  '';
}
