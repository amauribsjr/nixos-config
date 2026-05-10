{ fonts, theme, ... }:

{
  home.pointerCursor = {
    name       = theme.cursor.name;
    package    = theme.cursor.package;
    size       = theme.cursor.size;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    font   = { name = fonts.gtk; size = fonts.uiSize; };
    theme  = { inherit (theme.gtk) name package; };
    gtk4.theme = { inherit (theme.gtk) name package; };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme        = "prefer-dark";
      monospace-font-name = "${fonts.systemMono} ${toString fonts.uiSize}";
    };
  };
}
