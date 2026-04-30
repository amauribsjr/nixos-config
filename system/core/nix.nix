{ ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = 2;
      cores = 4;
    };

    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.command-not-found.enable = false;
}
