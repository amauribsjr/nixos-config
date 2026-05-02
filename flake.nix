{
  description = "koppi nixOS — Dell Inspiron 3501 (Niri)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, niri, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs   = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    colors = import ./lib/colors.nix;
    fonts  = import ./lib/fonts.nix;
  in {
    devShells.${system} = import ./devshells.nix { inherit pkgs; };
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs colors fonts; };
      modules = [
        nixos-hardware.nixosModules.common-pc-laptop
        nixos-hardware.nixosModules.common-pc-laptop-ssd
        nixos-hardware.nixosModules.common-cpu-intel
        ./system
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
