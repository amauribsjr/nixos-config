{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ─── Wayland / niri ecosystem ────────────────────────────────────────
    awww
    swaylock
    mako
    grim
    slurp
    swappy
    wl-clipboard
    networkmanagerapplet
    xwayland-satellite
    xdg-user-dirs-update

    # ─── TUI tools ───────────────────────────────────────────────────────
    yazi
    ffmpegthumbnailer
    unar
    poppler-utils
    imagemagick
    jq
    fd
    ripgrep
    fzf
    zoxide

  ];
}
