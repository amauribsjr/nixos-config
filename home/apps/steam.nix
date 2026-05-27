{
  xdg.desktopEntries.steam = {
    name = "Steam";
    icon = "steam";
    exec = "gamescope -- steam %U";
    terminal = false;
    categories = [ "Game" ];
    mimeType = [ "x-scheme-handler/steam" "x-scheme-handler/steamlink" ];
  };
}