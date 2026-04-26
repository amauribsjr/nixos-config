{ ... }:

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
        style             = "bold blue";
        read_only         = " 󰌾";
        truncation_length = 3;
        truncate_to_repo  = true;
        format            = "[$path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        symbol = " ";
        style  = "bold green";
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style     = "bold red";
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

      python = { symbol = " "; style = "bold yellow"; format = "[$symbol$pyenv_prefix($version)]($style) "; };
      nodejs = { symbol = " "; style = "bold green";  format = "[$symbol($version)]($style) "; };
      rust   = { symbol = " "; style = "bold orange"; format = "[$symbol($version)]($style) "; };
      java   = { symbol = " "; style = "bold red";    format = "[$symbol($version)]($style) "; };

      docker_context = {
        symbol = " ";
        style  = "bold blue";
        format = "[$symbol$context]($style) ";
      };

      package.disabled      = true;
      cmd_duration.disabled = true;

      # ─── darkSEA palette ─────────────────────────────────────────────────
      palettes.darksea = {
        bg0    = "#1b2430";
        fg     = "#d6e9ff";
        blue   = "#88b4e7";
        slate  = "#5d8cc0";
        mint   = "#34febb";
        teal   = "#32ae85";
        red    = "#e06b74";
        yellow = "#e5c07b";
        purple = "#a77bca";
        gray   = "#586f89";
        orange = "#e5a87c";
        green  = "#34febb";
        aqua   = "#32ae85";
      };
    };
  };
}
