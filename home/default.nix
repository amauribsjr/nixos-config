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

  # Wallpaper acessível via ~/Pictures/wallpaper.png (referenciado pelo niri).
  #home.file."Pictures/wallpaper.png".source = ./wallpaper.png;

  # =========================================================================
  # Auto-lock e auto-suspend (essencial em laptop)
  # =========================================================================
  # Trava em 5min ocioso, suspende em 10min, lock antes de qualquer suspend.
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.swaylock}/bin/swaylock -f -c 151f2e";
      }
      {
        timeout = 1800;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f -c 151f2e";
      lock         = "${pkgs.swaylock}/bin/swaylock -f -c 151f2e";
    };
  };
}
