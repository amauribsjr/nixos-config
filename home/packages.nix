{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Wayland & desktop
    awww
    networkmanagerapplet
    polkit_gnome

    # Screenshots
    grim
    slurp
    swappy

    # Terminal utilities
    yazi
    jq
    fd
    ripgrep
    chafa
    fastfetch
    claude-code

    # File & media
    ffmpegthumbnailer
    unar
    poppler-utils
    imagemagick

    # Launchers
    wofi

    # Apps
    google-chrome
    spotify
    vesktop
    obs-studio
    dbeaver-bin
    bruno
    zed-editor
    gnome-calculator
    gnome-text-editor
  ];
}