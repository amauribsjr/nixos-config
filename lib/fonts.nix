rec {
  ui       = "JetBrainsMono Nerd Font";
  code     = "VictorMono Nerd Font Mono";
  symbols  = "Symbols Nerd Font Mono";

  terminal  = code;
  gtk       = ui;
  systemMono = ui;

  mono       = code;
  globalMono = systemMono;

  terminalSize = 12;
  uiSize       = 12;
  waybarSize   = 13;
  launcherSize = 14;
  greeterSize  = 13;

  lockClockSize = 32;
  lockTextSize  = 13;

  size = terminalSize;
}