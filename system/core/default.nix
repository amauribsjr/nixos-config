{ ... }:
{
  imports = [
    ./nix.nix
    ./locale.nix
    ./networking.nix
    ./users.nix
    ./packages.nix
  ];

  systemd.oomd = {
    enable = true;
    enableRootSlice = true;
    enableSystemSlice = true;
    enableUserSlices = true;
  };
}