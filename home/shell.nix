{ colors, ... }:

let
  icon = cp: builtins.fromJSON "\"\\u${cp}\"";
  i = {
    git = icon "E0A0";
    nix = icon "F313";
    rust = icon "E7A8";
    python = icon "E73C";
    nodejs = icon "E718";
    java = icon "E738";
    docker = icon "F308";
  };
in

{
  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # Nix develop
      nd = "nix develop";

      # Project devShells from nixos-config
      ndd = "nix develop ~/nixos-config#default";
      ndj = "nix develop ~/nixos-config#java";
      ndr = "nix develop ~/nixos-config#rust";
      ndc = "nix develop ~/nixos-config#c";
      ndf = "nix develop ~/nixos-config#flutter";
    };

    initContent = ''

      function rebuild() {
        echo "🔄 Rebuilding NixOS..."
        sudo nixos-rebuild switch --flake ~/nixos-config#nixos
      }

      function update() {
        echo "🔄 Updating flake inputs..."
        cd ~/nixos-config || return 1
        nix flake update || return 1

        echo "🧪 Testing NixOS build..."
        sudo nixos-rebuild test --flake .#nixos
      }

      function flakeup() {
        echo "🔄 Updating flake.lock..."
        cd ~/nixos-config || return 1
        nix flake update || return 1

        git add flake.lock

        if git diff --cached --quiet; then
        echo "No flake.lock changes to commit."
        else
        git commit -m "chore(flake): update inputs"
        fi
      }

      function rollback() {
        echo "⏪ Rolling back..."
        sudo nixos-rebuild switch --rollback
      }

      function clean() {
        echo "🧹 Cleaning system generations older than 7 days..."
        sudo nix-collect-garbage --delete-older-than 7d
      }

      function deepclean() {
        echo "🧹 Keeping only last 3 generations..."
        sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system +3
        sudo nix-collect-garbage
      }

      function testbuild() {
        echo "🧪 Testing NixOS build..."
        cd ~/nixos-config || exit 1
        if [ -n "$(git status --porcelain)" ]; then
          echo "⚠️ There are uncommitted changes:"
          git status --short
          echo
          echo "If you've created new files, add them manually with git add <file>."
          echo
        fi
        sudo nixos-rebuild test --flake .#nixos
      }

      function wall() {
        local chosen
        chosen=$(find ~/Pictures/Wallpapers -maxdepth 1 \
            \( -type f -o -type l \) \
            \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) \
            -printf '%f\n' |
          fzf --prompt="wallpaper > " \
              --preview 'chafa --size=''${FZF_PREVIEW_COLUMNS}x''${FZF_PREVIEW_LINES} ~/Pictures/Wallpapers/{}' \
              --preview-window=right:60%:border)
        if [ -n "$chosen" ]; then
          awww img ~/Pictures/Wallpapers/"$chosen" --transition-type fade
          mkdir -p ~/.local/share
          echo "$chosen" > ~/.local/share/current-wallpaper
        fi
      }

      # Databases
      function pgstart() {
        sudo systemctl start postgresql;
        echo "PostgreSQL up → localhost:5432";
      }
      function pgstop() {
        sudo systemctl stop postgresql;
        echo "PostgreSQL down";
      }

      function mystart() {
        sudo systemctl start mysql;
        echo "MySQL up → localhost:3308";
      }

      function mystop() {
        sudo systemctl stop mysql;
        echo "MySQL down";
      }

      function redistart() {
        sudo systemctl start redis-dev;
        echo "Redis up → localhost:6379";
      }

      function redistop() {
        sudo systemctl stop redis-dev;
        echo "Redis down";
      }

      # devShell helpers
      export NIXOS_CONFIG="$HOME/nixos-config"

      # Generic: enter a devShell from nixos-config
      nds() {
        local shell="''${1:-default}"
        nix develop "$NIXOS_CONFIG#$shell"
      }

      # Generic: open Zed inside a devShell
      ndz() {
        local shell="''${1:-default}"
        local path="''${2:-.}"
        nix develop "$NIXOS_CONFIG#$shell" -c zed "$path"
      }

      # Open Zed inside specific devShells
      zjava() {
        nix develop "$NIXOS_CONFIG#java" -c zed "''${1:-.}"
      }

      zrust() {
        nix develop "$NIXOS_CONFIG#rust" -c zed "''${1:-.}"
      }

      zc() {
        nix develop "$NIXOS_CONFIG#c" -c zed "''${1:-.}"
      }

      zflutter() {
        nix develop "$NIXOS_CONFIG#flutter" -c zed "''${1:-.}"
      }
    '';
  };

  programs.zoxide = { enable = true; enableZshIntegration = true; };
  programs.fzf = { enable = true; enableZshIntegration = true; };

  # Starship
  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 1000;
      add_newline = true;
      palette = "koppi";

      palettes.koppi = {
        fg = "#${colors.fg}";
        blue = "#${colors.blue}";
        aqua = "#${colors.cyan}";
        green = "#${colors.green}";
        orange = "#${colors.accent}";
        purple = "#${colors.magenta}";
        red = "#${colors.red}";
        yellow = "#${colors.yellow}";
        accent = "#${colors.accent}";
        accdim = "#${colors.accdim}";
      };


      format = ''
        [╭─](fg)$username$hostname$directory$git_branch$git_status$nix_shell$python$nodejs$rust$java$docker_context
        [╰─](fg)$character'';

      character = {
        success_symbol = "[λ](green)";
        error_symbol = "[λ](red)";
      };

      username = { style_user = "fg"; style_root = "red"; format = "[$user]($style) "; disabled = false; show_always = true; };
      hostname = { ssh_only = false; format = "[@](yellow)[$hostname](blue) "; disabled = false; };
      directory = { style = "blue"; read_only = " 󰌾"; truncation_length = 3; truncate_to_repo = true; format = "[$path]($style)[$read_only]($read_only_style) "; };

      git_branch = { symbol = "${i.git} "; style = "red"; format = "[$symbol$branch]($style) "; };
      git_status = { style = "red"; conflicted = "🏳"; ahead = "⇡\${count}"; behind = "⇣\${count}"; diverged = "⇕⇡\${ahead_count}⇣\${behind_count}"; up_to_date = ""; untracked = "?\${count}"; stashed = "📦"; modified = "!\${count}"; staged = "+\${count}"; renamed = "»\${count}"; deleted = "✘\${count}"; format = ''([\[$all_status$ahead_behind\]]($style) )''; };
      nix_shell = { disabled = false; symbol = "${i.nix} "; impure_msg = "[impure](red)"; pure_msg = "[pure](green)"; unknown_msg = "[unknown](yellow)"; format = "via [$symbol$state( \\($name\\))](aqua) "; };
      rust = { symbol = "${i.rust} "; style = "orange"; format = "[$symbol($version)]($style) "; };
      python = { symbol = "${i.python} "; style = "yellow"; format = "[$symbol$pyenv_prefix($version)]($style) "; };
      nodejs = { symbol = "${i.nodejs} "; style = "green"; format = "[$symbol($version)]($style) "; };
      java = { symbol = "${i.java} "; style = "red"; format = "[$symbol($version)]($style) "; };
      docker_context = { symbol = "${i.docker} "; style = "blue"; format = "[$symbol$context]($style) "; };

      package.disabled = true;
      cmd_duration.disabled = true;

    };
  };
}