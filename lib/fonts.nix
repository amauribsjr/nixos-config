rec {
  ui       = "JetBrainsMono Nerd Font";
  code     = "VictorMono Nerd Font Mono";
  symbols  = "Symbols Nerd Font Mono";

  terminal   = code;
  systemMono = code;
  mono       = code;
  gtk        = ui;
  globalMono = systemMono;

  terminalSize = 10;
  uiSize       = 10;
  waybarSize   = 11;
  launcherSize = 12;
  greeterSize  = 11;

  lockClockSize = 32;
  lockTextSize  = 11;

  size = terminalSize;
}
