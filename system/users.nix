{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  users.users.barbosa = {
    isNormalUser = true;
    description = "barbosa";
    extraGroups = [
      "networkmanager"
      "wheel"            # sudo
      "docker"
      "video"            # brightnessctl
      "audio"
    ];
  };
}
