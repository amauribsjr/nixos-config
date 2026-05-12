{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Java
    jdk21
    maven

    # Rust
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
    gcc
    gnumake
    pkg-config

    # C
    gdb

    # Nix
    nil
    nixd
    nixfmt
    deadnix
    nvd
    
  ];
}
