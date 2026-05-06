{ ... }:
{
  home.file.".config/fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "type": "builtin",
        "source": "nixos",
        "padding": { "top": 1, "right": 3 },
        "color": {
          "1": "white",
          "2": "white"
        }
      },
      "modules": [
        {
          "type": "title",
          "format": "{user-name}@{host-name}",
          "color": { "user": "white", "at": "bright_black", "host": "bright_white" }
        },
        { "type": "separator", "string": "─────────────" },
        { "type": "host",     "key": "host",    "keyColor": "bright_yellow" },
        { "type": "os",       "key": "os",      "keyColor": "bright_white"  },
        { "type": "kernel",   "key": "kernel",  "keyColor": "bright_yellow"        },
        { "type": "packages", "key": "pkgs",    "keyColor": "bright_white"  },
        { "type": "separator", "string": "─────────────" },
        { "type": "cpu",    "key": "cpu",  "keyColor": "bright_yellow", "format": "{name}" },
        { "type": "memory", "key": "mem",  "keyColor": "bright_white"                            },
        { "type": "disk",   "key": "disk", "keyColor": "bright_yellow",  "folders": "/"     },
        { "type": "separator", "string": "─────────────" },
        { "type": "shell",    "key": "shell",    "keyColor": "bright_white" },
        { "type": "terminal", "key": "terminal", "keyColor": "bright_yellow"        },
        { "type": "wm",       "key": "wm",       "keyColor": "bright_white" }
      ]
    }
  '';
}
