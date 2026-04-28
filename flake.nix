{
  description = "koppi nixOS — Dell Inspiron 3501 (Niri)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
  };

  outputs = { self, nixpkgs, home-manager, niri, disko, ... }@inputs:
  let
    colors = import ./lib/colors.nix;
    fonts  = import ./lib/fonts.nix;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs colors fonts; };
      modules = [
        ./system
        ./disko.nix
        disko.nixosModules.disko
        niri.nixosModules.niri
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs colors fonts; };
            users.koppi = import ./home;
          };
        }
      ];
    };
  };
}
