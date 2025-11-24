{ config, pkgs, ... }:

{
  home.username = "barbosa";
  home.homeDirectory = "/home/barbosa";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  # --- Imports ---
  imports = [
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/alacritty.nix
    ./desktop/hyprland.nix
    ./desktop/waybar.nix
  ];

  home.packages = with pkgs; [
    # WM Tools
    rofi
    swaylock
    swayidle
    mako
    grim
    slurp
    swappy
    swww

    # File manager
    yazi
    ffmpegthumbnailer
    unar
    jq
    poppler-utils
    fd
    ripgrep
    fzf
    zoxide
    imagemagick
    xclip

    # Graphical
    xfce.thunar
  ];

  # --- Scripts ---
  home.file = {
    # Wallpaper
    "Pictures/wallpaper.png".source = ./wallpaper.png;
    
    # Spotify / Waybar
    ".config/waybar/scripts/spotify.sh" = {
      executable = true; 
      text = ''
      #!/usr/bin/env bash
    
      PLAYERCTL="${pkgs.playerctl}/bin/playerctl"
    
      STATUS=$($PLAYERCTL -p spotify status 2>/dev/null)

      if [ "$STATUS" = "Playing" ]; then
        ARTIST=$($PLAYERCTL -p spotify metadata artist 2>/dev/null)
        TITLE=$($PLAYERCTL -p spotify metadata title 2>/dev/null)

        TEXT="♫ $ARTIST - $TITLE"
        echo "{\"text\":\"$TEXT\", \"class\":\"playing\"}"
        
        elif [ "$STATUS" = "Paused" ]; then
          echo "{\"text\":\"♫ Paused\", \"class\":\"paused\"}"
        else
          echo ""
        fi
      '';
    };
    
    # Power Menu
    ".config/waybar/scripts/power.sh" = {
      text = ''
        #!/usr/bin/env bash
        
        option=$(echo -e "⏻ Shutdown\n⟳ Reboot\n⏾ Suspend\n Lock\n Logout" | rofi -dmenu -p "Power Menu" -i)
        
        case $option in
            "⏻ Shutdown")
                systemctl poweroff
                ;;
            "⟳ Reboot")
                systemctl reboot
                ;;
            "⏾ Suspend")
                systemctl suspend
                ;;
            " Lock")
                swaylock -f -c 000000
                ;;
            " Logout")
                hyprctl dispatch exit
                ;;
        esac
      '';
      executable = true;
    };
  };

  # --- Cursor ---
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  # --- GTK Theme ---
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
}
