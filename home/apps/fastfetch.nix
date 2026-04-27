{ ... }:

{
  home.file.".config/fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "source": "nixos_small",
        "padding": { "top": 1, "right": 3 }
      },
      "display": {
        "separator": "  ",
        "color": { "keys": "yellow", "title": "green" }
      },
      "modules": [
        { "type": "title",  "format": "{user-name}@{host-name}" },
        { "type": "separator", "string": "──────" },
        { "type": "host",   "key": "host  " },
        { "type": "os",     "key": "os    " },
        { "type": "kernel", "key": "kernel" },
        { "type": "cpu", "key": "cpu   ", "format": "{name}" }
        { "type": "memory", "key": "mem   " },
        { "type": "disk",   "key": "disk  ", "folders": "/" }
      ]
    }
  '';
}
