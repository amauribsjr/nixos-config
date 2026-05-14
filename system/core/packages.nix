{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # CLI
    vim
    wget
    curl
    git
    lazygit
    file
    tree
    zip
    unzip
    p7zip

    # System & hardware
    btop

    # Desktop
    wl-clipboard
    brightnessctl
    pamixer
    playerctl

    # Apps
    nautilus
    eog
    pavucontrol
    vlc
    mpv
  ];

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=20M
    MaxRetentionSec=2week
  '';
}