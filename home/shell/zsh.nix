{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      rebuild  = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      update   = "cd ~/nixos-config && nix flake update && sudo nixos-rebuild switch --flake .#nixos";
      cleanweek = "sudo nix-collect-garbage -d";
      clean    = "sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system +3 && sudo nix-collect-garbage";
      testbuild = "cd ~/nixos-config && git add . && sudo nixos-rebuild test --flake ~/nixos-config#nixos";
      rollback = "sudo nixos-rebuild switch --rollback";
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

      function nixos() {
        if [ "$1" = "rebuild" ]; then
          echo "🔄 Rebuilding NixOS..."
          sudo nixos-rebuild switch --flake ~/nixos-config#nixos
        elif [ "$1" = "update" ]; then
          echo "🔄 Updating flakes..."
          cd ~/nixos-config && nix flake update
          echo "🔄 Rebuilding..."
          sudo nixos-rebuild switch --flake ~/nixos-config#nixos
        elif [ "$1" = "rollback" ]; then
          echo "⏪ Rolling back..."
          sudo nixos-rebuild switch --rollback
        elif [ "$1" = "cleanweek" ]; then
          echo "🧹 Cleaning system 7 days old gens..."
          sudo nix-collect-garbage -d
        elif [ "$1" = "clean" ]; then
          echo "🧹 Keeping last 3 generations..."
          sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system +3
          sudo nix-collect-garbage
        else
          echo "⚠️ Unknown command. Try 'rebuild', 'update', 'rollback', 'clean', or 'cleanweek'."
        fi
      }
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
