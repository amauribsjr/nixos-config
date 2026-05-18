{
  description = "koppi nixOS — Dell Inspiron 3501 (Niri)";

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

      perSystem =
        { system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              android_sdk.accept_license = true;
            };
          };

          androidComposition = pkgs.androidenv.composeAndroidPackages {
            cmdLineToolsVersion = "13.0";
            platformToolsVersion = "35.0.2";
            buildToolsVersions = [ "35.0.0" ];
            platformVersions = [ "35" ];
            includeEmulator = false;
            includeSystemImages = false;
            includeSources = false;
            includeNDK = false;
          };

          androidSdk = androidComposition.androidsdk;
        in
        {
          devShells = {
            default = pkgs.mkShell {
              packages = with pkgs; [
                git
                nil
                nixd
                nixfmt
                deadnix
                nvd
              ];

              shellHook = ''
                echo "koppi devShell: default"
              '';
            };

            java = pkgs.mkShell {
              packages = with pkgs; [
                jdk21
                maven
              ];

              JAVA_HOME = pkgs.jdk21.home;

              shellHook = ''
                echo "koppi devShell: Java"
                java -version
              '';
            };

            rust = pkgs.mkShell {
              packages = with pkgs; [
                rustc
                cargo
                rust-analyzer
                rustfmt
                clippy
                gcc
                pkg-config
              ];

              RUST_BACKTRACE = "1";

              shellHook = ''
                echo "koppi devShell: Rust"
                rustc --version
              '';
            };

            c = pkgs.mkShell {
              packages = with pkgs; [
                gcc
                gnumake
                pkg-config
                gdb
              ];

              shellHook = ''
                echo "koppi devShell: C"
                gcc --version | head -n 1
              '';
            };

            flutter = pkgs.mkShell {
              packages = [
                pkgs.flutter
                androidSdk
                pkgs.android-tools
                pkgs.jdk21
              ];

              ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
              ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
              JAVA_HOME = pkgs.jdk21.home;

              shellHook = ''
                echo "koppi devShell: Flutter/Android"
                flutter --version
              '';
            };
          };
        };

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
                backupFileExtension = "hm-bak";

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