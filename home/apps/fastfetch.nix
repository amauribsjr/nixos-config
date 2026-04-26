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
          "1": "blue",
          "2": "cyan"
        }
      },
      "display": {
        "separator": "  ",
        "color": "cyan",
        "size": {
          "binaryPrefix": "si"
        }
      },
      "modules": [
        {
          "type": "title",
          "format": "{#36}{user-name}{#37}@{host-name}"
        },
        {
          "type": "separator",
          "string": "───────"
        },
        {
          "type": "cpu",
          "key": "╭─",
          "keyColor": "cyan",
          "showPeCoreCount": true
        },
        {
          "type": "gpu",
          "key": "├─󰢮",
          "keyColor": "cyan"
        },
        {
          "type": "memory",
          "key": "├─",
          "keyColor": "cyan"
        },
        {
          "type": "disk",
          "key": "╰─",
          "keyColor": "cyan",
          "folders": "/"
        },
        "break",
        {
          "type": "os",
          "key": "╭─",
          "keyColor": "blue"
        },
        {
          "type": "kernel",
          "key": "├─",
          "keyColor": "blue"
        },
        {
          "type": "packages",
          "key": "├─󰏖",
          "keyColor": "blue"
        },
        {
          "type": "uptime",
          "key": "╰─󰅐",
          "keyColor": "blue"
        },
        "break",
        {
          "type": "wm",
          "key": " ",
          "keyColor": "white"
        },
        {
          "type": "shell",
          "key": " ",
          "keyColor": "white"
        },
        {
          "type": "terminal",
          "key": " ",
          "keyColor": "white"
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
