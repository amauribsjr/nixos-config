{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  users.users.barbosa = {
    isNormalUser = true;
    description = "barbosa";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "audio"
    ];
  };
  
  users.users.koppi = {
    isNormalUser = true;
    description = "koppi";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "audio"
    ];
  };
}
