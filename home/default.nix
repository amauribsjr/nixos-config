{ pkgs, ... }:

{
  imports = [
    ./desktop/niri.nix
    ./desktop/waybar.nix
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

  home.username = "koppi";
  home.homeDirectory = "/home/koppi";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 600;  command = "${pkgs.swaylock}/bin/swaylock -f -c 282828"; }
      { timeout = 1800; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f -c 282828";
      lock         = "${pkgs.swaylock}/bin/swaylock -f -c 282828";
    };
  };
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 3000;
      ignore-timeout = false;
    };
  };
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = false; #warning silence *temporary*
  };
}
