{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Wayland & desktop
    awww
    swaylock
    networkmanagerapplet

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
    google-chrome
    vesktop
    obs-studio
    spotify

  ];
}
