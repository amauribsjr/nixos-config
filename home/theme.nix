{ pkgs, ... }:

{
  # =========================================================================
  # Cursor
  # =========================================================================
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  # =========================================================================
  # GTK theme (Adwaita-dark, combina com Gruvbox)
  # =========================================================================
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk4.theme = null;
  };
}
