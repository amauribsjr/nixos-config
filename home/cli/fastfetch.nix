{ ... }:

{
  home.file.".config/fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",

      "logo": {
        "source": "nixos_small",
        "padding": { "top": 1, "right": 3 }
      },

      "modules": [
        {
          "type": "title",
          "format": "{user-name}@{host-name}",
          "color": { "user": "bright_yellow", "at": "white", "host": "bright_green" }
        },
        { "type": "separator", "string": "─────────────" },

        { "type": "host",     "key": "host",    "keyColor": "magenta"      },
        { "type": "os",       "key": "os",      "keyColor": "cyan"         },
        { "type": "kernel",   "key": "kernel",  "keyColor": "yellow"       },
        { "type": "packages", "key": "pkgs",    "keyColor": "bright_green" },

        { "type": "separator", "string": "─────────────" },

        { "type": "cpu",    "key": "cpu",     "keyColor": "red",          "format": "{name}"  },
        { "type": "gpu",    "key": "gpu",     "keyColor": "214",          "format": "{name}"  },
        { "type": "memory", "key": "mem",     "keyColor": "green"                             },
        { "type": "disk",   "key": "disk",    "keyColor": "214",          "folders": "/"      },
        { "type": "battery","key": "battery", "keyColor": "bright_yellow"                     },

        { "type": "separator", "string": "─────────────" },

        { "type": "shell",    "key": "shell",    "keyColor": "blue",       "format": "{name}" },
        { "type": "terminal", "key": "terminal", "keyColor": "bright_cyan"                    },
        { "type": "wm",       "key": "wm",       "keyColor": "bright_blue"                    }
      ]
    }
  '';
}
