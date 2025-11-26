{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 1000;

      format = ''
        [╭─](bold #cba6f7)$username$hostname$directory$git_branch$git_status$nix_shell$python$nodejs$rust$java$docker_context$line_break[╰─](bold #cba6f7)$character'';

      character = {
        success_symbol = "[λ ](bold #a6e3a1)"; # Green
        error_symbol = "[λ ](bold #f38ba8)";   # Red
      };

      username = {
        style_user = "bold #cdd6f4"; # Text
        style_root = "bold #f38ba8"; # Red
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = "[@](bold #9399b2)[$hostname](bold #fab387) "; # Overlay2 @ Peach
        disabled = false;
      };

      directory = {
        style = "bold #89b4fa"; # Blue
        read_only = " 󰌾";
        truncation_length = 3;
        truncate_to_repo = true;
        format = "[$path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        symbol = " ";
        style = "bold #a6e3a1"; # Green
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style = "bold #f38ba8"; # Red
        conflicted = "🏳";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        up_to_date = "";
        untracked = "?\${count}";
        stashed = "📦";
        modified = "!\${count}";
        staged = "+\${count}";
        renamed = "»\${count}";
        deleted = "✘\${count}";
        format = ''([\[$all_status$ahead_behind\]]($style) )'';
      };

      nix_shell = {
        disabled = false;
        impure_msg = "[impure](bold #f38ba8)"; # Red
        pure_msg = "[pure](bold #a6e3a1)";     # Green
        unknown_msg = "[unknown](bold #f9e2af)"; # Yellow
        format = "via [ $state( \\($name\\))](bold #89b4fa) "; # Blue
      };

      python = {
        symbol = " ";
        style = "#f9e2af"; # Yellow
        format = "[$symbol$pyenv_prefix($version)]($style) ";
      };

      nodejs = {
        symbol = " ";
        style = "#a6e3a1"; # Green
        format = "[$symbol($version)]($style) ";
      };

      rust = {
        symbol = " ";
        style = "bold #fab387"; # Peach
        format = "[$symbol($version)]($style) ";
      };

      java = {
        symbol = " ";
        style = "#f38ba8"; # Red
        format = "[$symbol($version)]($style) ";
      };

      docker_context = {
        symbol = " ";
        style = "bold #89b4fa"; # Blue
        format = "[$symbol$context]($style) ";
      };

      package.disabled = true;
      cmd_duration.disabled = true;
    };
  };
}
