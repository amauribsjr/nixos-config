{
  description = "Koppi NixOS — Niri";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    koppi-theme = {
      url = "github:amauribsjr/koppi-theme";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixos-hardware,
      home-manager,
      niri,
      koppi-theme,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake.nixosConfigurations.nixos =
        let
          system = "x86_64-linux";

          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          colors = koppi-theme.lib.colors;
          fonts = import ./lib/fonts.nix;
          theme = import ./lib/theme.nix { inherit pkgs; };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs colors fonts theme;
          };

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

                extraSpecialArgs = {
                  inherit inputs colors fonts theme;
                };

                users.koppi = import ./home;
              };
            }
          ];
        };
    };
}