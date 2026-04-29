{ fonts, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "dockerfile"
      "make"
      "gruvbox"
      "java"
      "haskell"
      "ruby"
    ];

    userSettings = {
      theme = {
        mode  = "dark";
        light = "Rosé Pine Dawn";
        dark  = "Rosé Pine Moon";
      };

      ui_font_family     = fonts.mono;
      ui_font_size       = 14;
      buffer_font_family = fonts.mono;
      buffer_font_size   = 13;
      buffer_line_height = "comfortable";

      tab_size              = 4;
      hard_tabs             = false;
      preferred_line_length = 100;
      soft_wrap             = "none";
      relative_line_numbers = false;
      cursor_blink          = true;
      show_whitespaces      = "selection";
      indent_guides         = { enabled = true; line_width = 1; };

      format_on_save                     = "off";
      remove_trailing_whitespace_on_save = true;
      ensure_final_newline_on_save       = true;

      vim_mode      = false;
      tab_bar       = { show = true; };
      scrollbar     = { show = "auto"; };
      project_panel = { dock = "left"; default_width = 240; };

      git = {
        git_gutter   = "tracked_files";
        inline_blame = { enabled = true; delay_ms = 1000; };
      };

      terminal = {
        font_family    = fonts.mono;
        font_size      = 14;
        shell          = { program = "zsh"; };
        copy_on_select = true;
      };

      telemetry   = { diagnostics = false; metrics = false; };
      auto_update = false;
      features    = { copilot = false; };

      languages = {
        Rust    = { tab_size = 4; format_on_save = "off"; };
        Nix     = { tab_size = 2; language_servers = [ "nixd" ]; };
        Java    = { tab_size = 4; };
        Haskell = { tab_size = 2; };
        Ruby    = { tab_size = 2; language_servers = [ "solargraph" ]; };
        TOML    = { tab_size = 2; };
      };

      lsp = {
        rust-analyzer = {
          initialization_options = {
            check = { command = "clippy"; };
            cargo = { features = "all"; };
            inlayHints = {
              maxLength      = 25;
              parameterHints = { enable = true; };
              typeHints      = { enable = true; };
            };
          };
        };
      };
    };

    userKeymaps = [
      {
        context = "Editor";
        bindings = {
          "ctrl-shift-k" = "editor::DeleteLine";
        };
      }
    ];
  };
}
