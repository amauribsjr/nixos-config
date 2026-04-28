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
        "separator": "  "
      },
      "modules": [
        { "type": "title", "format": "{user-name}@{host-name}" },
        { "type": "separator", "string": "──────" },
        { "type": "host",   "key": "host  ", "keyColor": "magenta" },
        { "type": "os",     "key": "os    ", "keyColor": "cyan" },
        { "type": "kernel", "key": "kernel", "keyColor": "yellow" },
        { "type": "cpu",    "key": "cpu   ", "keyColor": "red",   "format": "{name}" },
        { "type": "memory", "key": "mem   ", "keyColor": "green" },
        { "type": "disk",   "key": "disk  ", "keyColor": "214",   "folders": "/" }
      ]
    }
  '';
}