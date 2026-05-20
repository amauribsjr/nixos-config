{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
    btop
    brightnessctl
    pamixer
    playerctl
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