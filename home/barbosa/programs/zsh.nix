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
          echo "🚀 Rebuilding NixOS..."
          sudo nixos-rebuild switch --flake ~/nixos-config#nixos
        elif [ "$1" = "update" ]; then
          echo "🔄 Updating flakes..."
          cd ~/nixos-config && nix flake update
          echo "🚀 Rebuilding..."
          sudo nixos-rebuild switch --flake ~/nixos-config#nixos
        elif [ "$1" = "clean" ]; then
          echo "🧹 Cleaning system..."
          sudo nix-collect-garbage -d
        else
          echo "⚠️  Unknown command. Try: 'nixos rebuild', 'nixos update', or 'nixos clean'"
        fi
      }
    '';
  };
}
