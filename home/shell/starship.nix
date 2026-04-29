{ colors, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 1000;
      add_newline = true;
      palette = "darksea";

      format = ''
        [╭─](bold fg)$username$hostname$directory$git_branch$git_status$nix_shell$python$nodejs$rust$java$docker_context
        [╰─](bold fg)$character'';

      character = {
        success_symbol = "[λ](bold green)";
        error_symbol   = "[λ](bold red)";
      };

      username = {
        style_user = "bold fg";
        style_root = "bold red";
        format     = "[$user]($style) ";
        disabled   = false;
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format   = "[@](bold yellow)[$hostname](bold blue) ";
        disabled = false;
      };

      directory = {
        style            = "bold blue";
        read_only        = " 󰌾";
        truncation_length = 3;
        truncate_to_repo = true;
        format           = "[$path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        symbol = " ";
        style  = "bold red";
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style      = "bold red";
        conflicted = "🏳";
        ahead      = "⇡\${count}";
        behind     = "⇣\${count}";
        diverged   = "⇕⇡\${ahead_count}⇣\${behind_count}";
        up_to_date = "";
        untracked  = "?\${count}";
        stashed    = "📦";
        modified   = "!\${count}";
        staged     = "+\${count}";
        renamed    = "»\${count}";
        deleted    = "✘\${count}";
        format     = ''([\[$all_status$ahead_behind\]]($style) )'';
      };

      nix_shell = {
        disabled    = false;
        symbol      = " ";
        impure_msg  = "[impure](bold red)";
        pure_msg    = "[pure](bold green)";
        unknown_msg = "[unknown](bold yellow)";
        format      = "via [$symbol$state( \\($name\\))](bold aqua) ";
      };

      rust   = { symbol = " "; style = "bold orange"; format = "[$symbol($version)]($style) "; };
      python = { symbol = " "; style = "bold yellow"; format = "[$symbol$pyenv_prefix($version)]($style) "; };
      nodejs = { symbol = " "; style = "bold green";  format = "[$symbol($version)]($style) "; };
      java   = { symbol = " "; style = "bold red";    format = "[$symbol($version)]($style) "; };
      docker_context = { symbol = " "; style = "bold blue"; format = "[$symbol$context]($style) "; };

      package.disabled      = true;
      cmd_duration.disabled = true;

      palettes.darksea = {
        bg0    = "#${colors.bg}";
        fg     = "#${colors.fg}";
        blue   = "#${colors.blue}";
        slate  = "#${colors.slate}";
        mint   = "#${colors.bcyan}";
        teal   = "#${colors.teal}";
        red    = "#${colors.bred}";
        yellow = "#${colors.byellow}";
        purple = "#${colors.bmagenta}";
        gray   = "#${colors.fg2}";
        orange = "#${colors.orange}";
        green  = "#${colors.bgreen}";
        aqua   = "#${colors.bcyan}";
      };
    };
  };
}