{ pkgs, ... }:

{
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
  
    theme = {
      name = "Kanagawa";
      package = pkgs.kanagawa-gtk-theme;
    };
  
    gtk4.theme = {
      name = "Kanagawa";
      package = pkgs.kanagawa-gtk-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
