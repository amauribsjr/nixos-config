{ ... }:

{
  home.file.".config/fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "source": "nixos",
        "padding": {
          "top": 1,
          "right": 4
        },
        "color": {
          "1": "yellow",
          "2": "green"
        }
      },
      "display": {
        "separator": "  ",
        "color": "green",
        "size": {
          "binaryPrefix": "si"
        }
      },
      "modules": [
        {
          "type": "title",
          "format": "{#33}{user-name}{#37}@{host-name}"
        },
        {
          "type": "separator",
          "string": "───────"
        },
        {
          "type": "cpu",
          "key": "╭─",
          "keyColor": "green",
          "showPeCoreCount": true
        },
        {
          "type": "gpu",
          "key": "├─󰢮",
          "keyColor": "green"
        },
        {
          "type": "memory",
          "key": "├─",
          "keyColor": "green"
        },
        {
          "type": "disk",
          "key": "╰─",
          "keyColor": "green",
          "folders": "/"
        },
        "break",
        {
          "type": "os",
          "key": "╭─",
          "keyColor": "yellow"
        },
        {
          "type": "kernel",
          "key": "├─",
          "keyColor": "yellow"
        },
        {
          "type": "packages",
          "key": "├─󰏖",
          "keyColor": "yellow"
        },
        {
          "type": "uptime",
          "key": "╰─󰅐",
          "keyColor": "yellow"
        },
        "break",
        {
          "type": "wm",
          "key": " ",
          "keyColor": "blue"
        },
        {
          "type": "shell",
          "key": " ",
          "keyColor": "blue"
        },
        {
          "type": "terminal",
          "key": " ",
          "keyColor": "blue"
        },
        "break",
        {
          "type": "colors",
          "symbol": "circle"
        }
      ]
    }
  '';
}
