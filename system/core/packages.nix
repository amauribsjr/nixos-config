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
    lm_sensors

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

    # Java
    jdk21
    maven

    # Rust
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
    gcc
    gnumake
    pkg-config

    # C
    gdb

    # Nix
    nil
    nixd
    nixfmt
    deadnix
    nvd
    
  ];

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=20M
    MaxRetentionSec=2week
  '';
}
