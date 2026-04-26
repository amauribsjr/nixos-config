{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ─── Wayland / niri ecosystem ────────────────────────────────────────
    swaybg               # wallpaper (niri-friendly, mais leve que swww)
    swaylock             # lock screen
    mako                 # notification daemon
    grim                 # screenshot
    slurp                # seleção de área
    swappy               # editor de screenshot
    wl-clipboard         # clipboard helpers
    networkmanagerapplet # nm-applet (tray do NM)
    xwayland-satellite   # XWayland sob demanda (niri usa esse)

    # ─── TUI tools ───────────────────────────────────────────────────────
    yazi                 # file manager TUI
    ffmpegthumbnailer    # thumbnails de vídeo no yazi
    unar                 # extração universal pro yazi
    poppler-utils        # preview de PDF no yazi
    imagemagick          # preview de imagem no yazi
    jq                   # JSON
    fd                   # find moderno
    ripgrep              # grep moderno
    fzf                  # fuzzy finder
    zoxide               # cd inteligente

    # --- NIX LSP tools ──────────────────────────────────────────────────
    nil
    nixpkgs-fmt

    # Nota: Thunar está via system/packages.nix (pra ter gvfs/plugins).
  ];
}
