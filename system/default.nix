{ ... }:

{
  imports = [
    ./hardware
    ./desktop.nix
    ./greeter.nix
    ./core
    ./development
  ];

  system.stateVersion = "24.05";
}