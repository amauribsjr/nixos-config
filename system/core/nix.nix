{ ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = 1;
      cores = 4;
    };

    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;
}
