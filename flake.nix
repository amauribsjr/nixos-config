{
  description = "barbosa nixOS — Dell Inspiron 3501 (Niri)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri scrollable-tiling Wayland compositor.
    # O flake oficial fornece NixOS module + Home Manager module + cache
    # binário em niri.cachix.org (essencial em Pentium Gold pra não compilar
    # niri do zero a cada update).
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Sistema
        ./system

        # Niri (system-level: sessão D-Bus, polkit, etc.)
        niri.nixosModules.niri

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs; };

            # Module do niri pro Home Manager (programs.niri.settings).
            #sharedModules = [ niri.homeModules.niri ];

            users.barbosa = import ./home;
          };
        }
      ];
    };
  };
}
