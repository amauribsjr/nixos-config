{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ─── CLI core ────────────────────────────────────────────────────────
    vim
    wget
    curl
    git
    btop
    htop
    wl-clipboard
    unzip
    file
    tree

    # ─── System tools ───────────────────────────────────────────────────
    bibata-cursors
    playerctl
    psmisc
    fastfetch
    pciutils
    usbutils
    brightnessctl              # controle de brilho da tela
    pamixer                    # controle de volume CLI
    powertop                   # diagnóstico de consumo
    lm_sensors                 # temperatura da CPU
    intel-gpu-tools            # `intel_gpu_top` mostra uso da iGPU
    nautilus

    # ─── Áudio control ───────────────────────────────────────────────────
    pavucontrol

    # ─── Greeter ─────────────────────────────────────────────────────────
    #tuigreet

    # ─── Apps ────────────────────────────────────────────────────────────
    google-chrome
    vesktop
    obs-studio                 # gravação/streaming
    vlc                        # player de mídia
    spotify
    gnome-software             # frontend Flatpak (loja)

    # ─── Editores ────────────────────────────────────────────────────────
    zed-editor
    vscode

    # ─── Linguagens / Build ──────────────────────────────────────────────
    jdk21
    maven                      # padrão do curso do Nelio
    rustup
    #rust-analyzer              # LSP usado pelo Zed/VSCode
    #clippy                     # linter Rust
    #rustfmt                    # formatter Rust
    gcc
    gnumake
    pkg-config

    # ─── DB ──────────────────────────────────────────────────────────────
    dbeaver-bin                # cliente GUI
    sqlite                     # CLI + driver leve
  ];

  # =========================================================================
  # Programas que precisam de integração system-level
  # =========================================================================

  # File manager Thunar com gvfs (montar USB) e plugins.
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin    # extrair zip/tar pelo menu
      thunar-volman            # automount de USB
    ];
  };
  services.gvfs.enable = true;     # montar dispositivos no Thunar
  services.tumbler.enable = true;  # gerar thumbnails

  # Limita logs do journald (SSD apertado).
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=20M
    MaxRetentionSec=2week
  '';

  # ssh-agent automático.
  #programs.ssh.startAgent = true;
}
