{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # CLI
    vim
    wget
    curl
    git
    file
    tree
    zip
    unzip
    p7zip             # .7z support
    lazygit           # git TUI

    # System & hardware
    btop
    htop
    fastfetch
    powertop          # power consumption analyzer
    lm_sensors        # temperature sensors
    pciutils          # lspci
    usbutils          # lsusb
    intel-gpu-tools
    psmisc            # pstree, killall, etc

    # Desktop
    wl-clipboard
    brightnessctl
    pamixer           # volume CLI
    playerctl         # media keys CLI
    bibata-cursors
    gnome-disk-utility

    # Apps
    nautilus
    eog               # image viewer
    pavucontrol
    google-chrome
    vesktop
    obs-studio
    vlc
    mpv
    spotify
    gnome-software
    pandoc            # document converter

    # Editors
    zed-editor
    vscode

    # Java
    jdk21
    maven

    # Rust
    rustup
    gcc
    gnumake
    pkg-config

    # C
    gdb

    # Haskell
    ghc
    cabal-install
    haskell-language-server

    # Ruby
    ruby
    rubyPackages.solargraph   # LSP

    # Nix
    nil               # Nix LSP

    # Databases
    dbeaver-bin
    sqlite

  ];

  services.gvfs.enable = true;

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=20M
    MaxRetentionSec=2week
  '';
}