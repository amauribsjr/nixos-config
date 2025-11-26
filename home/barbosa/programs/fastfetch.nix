{ ... }:

{
  # Configuração do Fastfetch com Catppuccin Mocha
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
          "2": "magenta"
        }
      },
      "display": {
        "separator": "  ",
        "color": "blue",
        "size": {
          "binaryPrefix": "si"
        }
      },
      "modules": [
        {
          "type": "title",
          "format": "{#35}{user-name}{#34}@{host-name}"
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
          "keyColor": "magenta"
        },
        {
          "type": "shell",
          "key": " ",
          "keyColor": "magenta"
        },
        {
          "type": "terminal",
          "key": " ",
          "keyColor": "magenta"
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
