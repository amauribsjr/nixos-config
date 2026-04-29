{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Wayland & desktop
    awww
    swaylock
    networkmanagerapplet
    wl-clipboard

    # Screenshots
    grim
    slurp
    swappy

    # Terminal utilities
    yazi
    jq
    fd
    ripgrep

    # File & media
    ffmpegthumbnailer
    unar
    poppler-utils
    imagemagick

    # Launchers
    wofi

    # Apps
    obsidian

  ];
}
