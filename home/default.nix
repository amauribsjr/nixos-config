{ pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./theme.nix
    ./niri.nix
    ./waybar.nix
    ./shell/zsh.nix
    ./shell/starship.nix
    ./terminal/alacritty.nix
    ./apps/fastfetch.nix
    ./apps/fuzzel.nix
  ];

  home.username = "barbosa";
  home.homeDirectory = "/home/barbosa";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 600;  command = "${pkgs.swaylock}/bin/swaylock -f -c 32302f"; }
      { timeout = 1800; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f -c 32302f";
      lock         = "${pkgs.swaylock}/bin/swaylock -f -c 32302f";
    };
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
