{ ... }:

{
  imports = [
    ./hardware
    ./desktop.nix
    ./greeter.nix
    ./core
  ];

  system.stateVersion = "24.05";
}
