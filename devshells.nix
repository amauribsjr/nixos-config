{ pkgs }:

{
  rust = pkgs.mkShell {
    packages = with pkgs; [
      rustc
      cargo
      rust-analyzer
      rustfmt
      clippy

      gcc
      gnumake
      pkg-config
    ];

    shellHook = ''
      echo "🦀 Rust dev shell"
      echo "Cargo: $(cargo --version)"
    '';
  };

  java = pkgs.mkShell {
    packages = with pkgs; [
      jdk21
      maven
    ];

    shellHook = ''
      echo "☕ Java dev shell"
      java --version
      mvn --version | head -n 1
    '';
  };

  c = pkgs.mkShell {
    packages = with pkgs; [
      gcc
      gnumake
      gdb
      valgrind
      pkg-config
    ];

    shellHook = ''
      echo "C dev shell"
      gcc --version | head -n 1
    '';
  };
}