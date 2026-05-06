{ colors, ... }:

let
  icon = cp: builtins.fromJSON "\"\\u${cp}\"";
  i = {
    git    = icon "E0A0";  #
    nix    = icon "F313";  #
    rust   = icon "E7A8";  #
    python = icon "E73C";  #
    nodejs = icon "E718";  #
    java   = icon "E738";  #
    docker = icon "F308";  #
  };
in

{
  # Zsh
  programs.zsh = {
    enable                    = true;
    enableCompletion          = true;
    autosuggestion.enable     = true;
    syntaxHighlighting.enable = true;

    shellAliases = {

      # DevShells
      rshell = "nix develop ~/nixos-config#rust";
      jshell = "nix develop ~/nixos-config#java";
      cshell = "nix develop ~/nixos-config#c";

      # Open editors inside DevShells
      rzed = "nix develop ~/nixos-config#rust -c zed .";
      jzed = "nix develop ~/nixos-config#java -c zed .";
      czed = "nix develop ~/nixos-config#c -c zed .";
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

      function rebuild() {
        echo "🔄 Rebuilding NixOS..."
        sudo nixos-rebuild switch --flake ~/nixos-config#nixos
      }

      function update() {
        echo "🔄 Updating flakes..."
        cd ~/nixos-config && nix flake update
        echo "🔄 Rebuilding..."
        cd ~/nixos-config && git add . && git commit -m "Update flakes"
        sudo nixos-rebuild switch --flake ~/nixos-config#nixos
      }

      function flakeup() {
        echo "🔄 Updating flake.lock..."
        cd ~/nixos-config && nix flake update
        cd ~/nixos-config && git add . && git commit -m "Update flake.lock"
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
          echo "$chosen" > ~/.local/share/current-wallpaper
        fi
      }
    '';
  };

  programs.nix-index = { enable = false; enableZshIntegration = false; };
  programs.zoxide    = { enable = true; enableZshIntegration  = true;  };
  programs.fzf       = { enable = true; enableZshIntegration  = true;  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config.global.hide_env_diff = true;
    silent = true;
  };

  # Starship
  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 1000;
      add_newline     = true;
      palette         = "gruvbox";

      palettes.gruvbox = {
        fg     = "#${colors.fg}";
        blue   = "#${colors.blue}";
        aqua   = "#${colors.cyan}";
        green  = "#${colors.green}";
        orange = "#${colors.orange}";
        purple = "#${colors.magenta}";
        red    = "#${colors.red}";
        yellow = "#${colors.yellow}";
      };


      format = ''
        [╭─](bold fg)$username$hostname$directory$git_branch$git_status$nix_shell$python$nodejs$rust$java$docker_context
        [╰─](bold fg)$character'';

      character = {
        success_symbol = "[λ](bold green)";
        error_symbol   = "[λ](bold red)";
      };

      username = { style_user = "bold fg"; style_root = "bold red"; format = "[$user]($style) "; disabled = false; show_always = true; };
      hostname = { ssh_only = false; format = "[@](bold yellow)[$hostname](bold blue) "; disabled = false; };
      directory = { style = "bold blue"; read_only = " 󰌾"; truncation_length = 3; truncate_to_repo = true; format = "[$path]($style)[$read_only]($read_only_style) "; };

      git_branch     = { symbol = "${i.git} "; style = "bold red";    format = "[$symbol$branch]($style) "; };
      git_status     = { style = "bold red"; conflicted = "🏳"; ahead = "⇡\${count}"; behind = "⇣\${count}"; diverged = "⇕⇡\${ahead_count}⇣\${behind_count}"; up_to_date = ""; untracked = "?\${count}"; stashed = "📦"; modified = "!\${count}"; staged = "+\${count}"; renamed = "»\${count}"; deleted = "✘\${count}"; format = ''([\[$all_status$ahead_behind\]]($style) )''; };
      nix_shell      = { disabled = false; symbol = "${i.nix} "; impure_msg = "[impure](bold red)"; pure_msg = "[pure](bold green)"; unknown_msg = "[unknown](bold yellow)"; format = "via [$symbol$state( \\($name\\))](bold aqua) "; };
      rust           = { symbol = "${i.rust} ";   style = "bold orange"; format = "[$symbol($version)]($style) "; };
      python         = { symbol = "${i.python} "; style = "bold yellow"; format = "[$symbol$pyenv_prefix($version)]($style) "; };
      nodejs         = { symbol = "${i.nodejs} "; style = "bold green";  format = "[$symbol($version)]($style) "; };
      java           = { symbol = "${i.java} ";   style = "bold red";    format = "[$symbol($version)]($style) "; };
      docker_context = { symbol = "${i.docker} "; style = "bold blue";   format = "[$symbol$context]($style) "; };

      package.disabled      = true;
      cmd_duration.disabled = true;

    };
  };
}
