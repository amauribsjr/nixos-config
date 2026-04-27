{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      y = "yazi";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      update = "cd ~/nixos-config && nix flake update && sudo nixos-rebuild switch --flake .#nixos";
      clean = "sudo nix-collect-garbage -d";
      cleanall = "sudo nix-collect-garbage --delete-older-than 1d";
      testbuild = "cd ~/nixos-config && git add . && sudo nixos-rebuild test --flake ~/nixos-config#nixos";
    };

    initContent = ''
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      # NixOS helper function
      function nixos() {
        if [ "$1" = "rebuild" ]; then
          echo "🔄 Rebuilding NixOS..."
          sudo nixos-rebuild switch --flake ~/nixos-config#nixos
        elif [ "$1" = "update" ]; then
          echo "🔄 Updating flakes..."
          cd ~/nixos-config && nix flake update
          echo "🔄 Rebuilding..."
          sudo nixos-rebuild switch --flake ~/nixos-config#nixos
        elif [ "$1" = "clean" ]; then
          echo "🧹 Cleaning system 7 days old gens..."
          sudo nix-collect-garbage -d
        elif [ "$1" = "cleanall" ]; then
          echo "🧹 Cleaning 1 day old gens..."
          sudo nix-collect-garbage --delete-older-than 1d
        else
          echo "⚠️ Unknown command."
        fi
      }
    '';
  };
}
