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
          "1": "#89b4fa",
          "2": "#f9e2af"
        }
      },
      "display": {
        "separator": "  ",
        "color": "#89b4fa",
        "size": {
          "binaryPrefix": "si"
        }
      },
      "modules": [
        {
          "type": "title",
          "format": "{#cba6f7}{user-name}{#89b4fa}@{host-name}"
        },
        {
          "type": "separator",
          "string": "───────"
        },
        {
          "type": "cpu",
          "key": "╭─",
          "keyColor": "#a6e3a1",
          "showPeCoreCount": true
        },
        {
          "type": "gpu",
          "key": "├─󰢮",
          "keyColor": "#a6e3a1"
        },
        {
          "type": "memory",
          "key": "├─",
          "keyColor": "#a6e3a1"
        },
        {
          "type": "disk",
          "key": "╰─",
          "keyColor": "#a6e3a1",
          "folders": "/"
        },
        "break",
        {
          "type": "os",
          "key": "╭─",
          "keyColor": "#f9e2af"
        },
        {
          "type": "kernel",
          "key": "├─",
          "keyColor": "#f9e2af"
        },
        {
          "type": "packages",
          "key": "├─󰏖",
          "keyColor": "#f9e2af"
        },
        {
          "type": "uptime",
          "key": "╰─󰅐",
          "keyColor": "#f9e2af"
        },
        "break",
        {
          "type": "wm",
          "key": " ",
          "keyColor": "#cba6f7"
        },
        {
          "type": "shell",
          "key": " ",
          "keyColor": "#cba6f7"
        },
        {
          "type": "terminal",
          "key": " ",
          "keyColor": "#cba6f7"
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
