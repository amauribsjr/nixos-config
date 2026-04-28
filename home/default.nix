{ pkgs, colors, ... }:

{
  imports = [
    ./desktop/niri.nix
    ./desktop/waybar.nix
    ./packages.nix
    ./theme.nix
    ./shell/zsh.nix
    ./shell/starship.nix
    ./terminal/alacritty.nix
    ./apps/fastfetch.nix
    ./apps/fuzzel.nix
    ./apps/awww.nix
    ./apps/nwg-drawer.nix
  ];

  home.username = "koppi";
  home.homeDirectory = "/home/koppi";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 600;  command = "${pkgs.swaylock}/bin/swaylock -f -c ${colors.bg}"; }
      { timeout = 1800; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f -c ${colors.bg}";
      lock         = "${pkgs.swaylock}/bin/swaylock -f -c ${colors.bg}";
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
    setSessionVariables = false;
  };
}
