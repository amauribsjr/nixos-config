{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Wayland & desktop
    awww                 # wallpaper daemon
    swaylock
    mako                 # notification daemon
    networkmanagerapplet
    xwayland-satellite   # X11 compatibility layer
    xdg-user-dirs
    wl-clipboard

    # Screenshots
    grim
    slurp                # region selector
    swappy               # screenshot editor

    # Terminal utilities
    yazi                 # file manager TUI
    jq                   # JSON processor
    fd                   # fast find alternative
    ripgrep
    fzf                  # fuzzy finder
    zoxide               # smart cd

    # File & media
    ffmpegthumbnailer    # video thumbnails in yazi
    unar                 # universal extractor
    poppler-utils        # PDF utilities
    imagemagick

    # Launchers
    wofi

    # Apps
    obsidian

  ];
}
