{ pkgs, ... }:

let
  clipboardMenu = pkgs.writeShellScriptBin "clipmenu" ''
    selected="$(${pkgs.cliphist}/bin/cliphist list |
      ${pkgs.wofi}/bin/wofi \
        --dmenu \
        --conf "$HOME/.config/wofi/config" \
        --style "$HOME/.config/wofi/center.css" \
        --prompt "clipboard > ")"

    if [ -n "$selected" ]; then
      printf '%s' "$selected" |
        ${pkgs.cliphist}/bin/cliphist decode |
        ${pkgs.wl-clipboard}/bin/wl-copy
    fi
  '';

  clipboardClear = pkgs.writeShellScriptBin "clipclear" ''
    ${pkgs.cliphist}/bin/cliphist wipe
  '';
in

{
  home.packages = [
    pkgs.wl-clipboard
    clipboardMenu
    clipboardClear
  ];

  services.cliphist = {
    enable = true;
    systemdTargets = [ "graphical-session.target" ];
    allowImages = true;

    extraOptions = [
      "-max-items" "500"
      "-max-dedupe-search" "10"
    ];
  };

  services.wl-clip-persist = {
    enable = true;
    systemdTargets = [ "graphical-session.target" ];
    clipboardType = "regular";
  };
}