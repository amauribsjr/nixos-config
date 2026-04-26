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

  home.file."Pictures/wallpaper.png".source = ./wallpaper.png;

  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f -c 1b2430"; }
      { timeout = 600; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f -c 1b2430"; }
      { event = "lock";         command = "${pkgs.swaylock}/bin/swaylock -f -c 1b2430"; }
    ];
  };
}
