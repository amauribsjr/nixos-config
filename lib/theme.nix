{ pkgs }: {
  gtk = {
    name    = "Gruvbox-Dark";
    package = pkgs.gruvbox-gtk-theme;
  };

  cursor = {
    name    = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size    = 20;
  };

  fontPackages = {
    ui   = pkgs.inter;
    code = pkgs.nerd-fonts.victor-mono;
    mono = pkgs.nerd-fonts.jetbrains-mono;
    syms = pkgs.nerd-fonts.symbols-only;
  };

  wallpaper = {
    default = "wallpaper.png";
    stateFile = ".local/share/current-wallpaper";
  };
}