{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jdk21
    maven
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
    gcc
    gnumake
    pkg-config
    gdb
    nil
    nixd
    nixfmt
    deadnix
    nvd
  ];
}