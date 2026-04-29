{ ... }:

{
  imports = [
    ./hardware
    ./desktop.nix
    ./core
  ];

  system.stateVersion = "24.05";
}