{ pkgs, ... }:

let
  clearLabel = "⟳ Clear clipboard history";

  clipboardMenu = pkgs.writeShellScriptBin "clipmenu" ''
    set -u

    selected="$(
      {
        printf '%s\n' "${clearLabel}"
        ${pkgs.cliphist}/bin/cliphist list
      } |
        ${pkgs.wofi}/bin/wofi --dmenu --location=top --yoffset=180 --conf "$HOME/.config/wofi/config" --style "$HOME/.config/wofi/center.css" --prompt "Clipboard >")"

    case "$selected" in
      "${clearLabel}"|"clear"|":clear")
        ${pkgs.cliphist}/bin/cliphist wipe
        ${pkgs.wl-clipboard}/bin/wl-copy --clear
        exit 0
        ;;
      "")
        exit 0
        ;;
      *)
        printf '%s' "$selected" |
          ${pkgs.cliphist}/bin/cliphist decode |
          ${pkgs.wl-clipboard}/bin/wl-copy
        ;;
    esac
  '';

  clipboardClear = pkgs.writeShellScriptBin "clipclear" ''
    ${pkgs.cliphist}/bin/cliphist wipe
    ${pkgs.wl-clipboard}/bin/wl-copy --clear
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
      "-max-items" "50"
      "-max-dedupe-search" "10"
    ];
  };

  services.wl-clip-persist = {
    enable = true;
    systemdTargets = [ "graphical-session.target" ];
    clipboardType = "regular";
  };
}