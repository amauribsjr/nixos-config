{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 1000;
      
      format = ''
        [╭─](bold #fabd2f)$username$hostname$directory$git_branch$git_status$nix_shell$python$nodejs$rust$java$docker_context$line_break[╰─](bold #fabd2f)$character'';

      character = {
        success_symbol = "[λ ](bold #83a598)";
        error_symbol = "[λ ](bold #fb4934)";
      };

      username = {
        style_user = "bold #ebdbb2";
        style_root = "bold #fb4934";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = "[@](bold #928374)[$hostname](bold #fe8019) ";
        disabled = false;
      };

      directory = {
        style = "bold #83a598";
        read_only = " 󰌾";
        truncation_length = 3;
        truncate_to_repo = true;
        format = "[$path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        symbol = " ";
        style = "bold #b8bb26";
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style = "bold #fb4934";
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
        impure_msg = "[impure](bold #fb4934)";
        pure_msg = "[pure](bold #b8bb26)";
        unknown_msg = "[unknown](bold #fabd2f)";
        format = "via [ $state( \\($name\\))](bold #83a598) ";
      };

      python = {
        symbol = " ";
        style = "#fabd2f";
        format = "[$symbol$pyenv_prefix($version)]($style) ";
      };

      nodejs = {
        symbol = " ";
        style = "#b8bb26";
        format = "[$symbol($version)]($style) ";
      };

      rust = {
        symbol = " ";
        style = "bold #fe8019";
        format = "[$symbol($version)]($style) ";
      };

      java = {
        symbol = " ";
        style = "#fb4934";
        format = "[$symbol($version)]($style) ";
      };

      docker_context = {
        symbol = " ";
        style = "bold #83a598";
        format = "[$symbol$context]($style) ";
      };

      package.disabled = true;
      cmd_duration.disabled = true;
    };
  };
}
