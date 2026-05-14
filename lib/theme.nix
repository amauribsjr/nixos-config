{ pkgs }: {
  gtk = {
    name = "Gruvbox-Dark";
    package = pkgs.gruvbox-gtk-theme;
  };

  cursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 20;
  };

  fontPackages = {
    ui = pkgs.nerd-fonts.jetbrains-mono;
    mono = pkgs.nerd-fonts.victor-mono;
    syms = pkgs.nerd-fonts.symbols-only;
  };

  wallpaper = {
    default = "wallpaper.png";
    stateFile = ".local/share/current-wallpaper";
  };
}