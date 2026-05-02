{ pkgs, ... }:

{
  home.packages = with pkgs; [
    clang-tools
    jdt-language-server
    marksman
  ];

  programs.helix = {
    enable = true;

    settings = {
      theme = "gruvbox-dark-hard";

      editor = {
        line-number          = "relative";
        cursorline           = true;
        color-modes          = true;
        scroll-lines         = 3;
        shell                = [ "bash" "-c" ];
        rulers               = [ 100 ];
        bufferline           = "multiple";
        auto-format          = false;

        auto-save = {
          focus-lost          = true;
          after-delay.enable  = true;
          after-delay.timeout = 3000;
        };

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        statusline = {
          left   = [ "mode" "spinner" "file-name" "file-modification-indicator" ];
          center = [ "version-control" ];
          right  = [ "diagnostics" "selections" "position" "file-encoding" "file-type" ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        inline-diagnostics = {
          cursor-line      = "warning";
          other-lines      = "error";
        };

        lsp = {
          display-messages    = true;
          display-inlay-hints = true;
        };

        indent-guides = {
          render      = true;
          character   = "╎";
          skip-levels = 1;
        };

        file-picker = {
          hidden     = false;
          ignore     = true;
          git-ignore = true;
        };

        soft-wrap.enable       = false;
        completion-trigger-len = 2;
      };

      keys = {
        normal = {
          "C-s"     = ":write";
          "C-w"     = ":buffer-close";
          "C-right" = ":buffer-next";
          "C-left"  = ":buffer-previous";
          "C-p"     = "file_picker";
          "C-/"     = "toggle_comments";
          g = {
            "d" = "goto_definition";
            "r" = "goto_reference";
            "i" = "goto_implementation";
            "t" = "goto_type_definition";
          };
          space = {
            "f" = "file_picker";
            "b" = "buffer_picker";
            "s" = "symbol_picker";
            "a" = "code_action";
            "d" = "diagnostics_picker";
            "r" = "rename_symbol";
            "h" = "hover";
            "w" = ":write";
          };
        };
        insert = {
          "C-s" = [ ":write" ];
        };
      };
    };

    themes.gruvbox-dark-hard = {
      inherits = "gruvbox";
      "ui.background"           = { bg = "#1d2021"; };
      "ui.background.separator" = { fg = "#504945"; };
      "ui.statusline"           = { fg = "#ebdbb2"; bg = "#282828"; };
      "ui.statusline.inactive"  = { fg = "#a89984"; bg = "#1d2021"; };
      "ui.statusline.normal"    = { fg = "#1d2021"; bg = "#a89984"; modifiers = ["bold"]; };
      "ui.statusline.insert"    = { fg = "#1d2021"; bg = "#b8bb26"; modifiers = ["bold"]; };
      "ui.statusline.select"    = { fg = "#1d2021"; bg = "#fabd2f"; modifiers = ["bold"]; };
      "ui.cursor.normal"        = { fg = "#1d2021"; bg = "#ebdbb2"; };
      "ui.cursor.insert"        = { fg = "#1d2021"; bg = "#b8bb26"; };
      "ui.cursor.select"        = { fg = "#1d2021"; bg = "#fabd2f"; };
      "ui.cursor.match"         = { fg = "#1d2021"; bg = "#fabd2f"; };
      "ui.cursorline.primary"   = { bg = "#282828"; };
      "ui.selection"            = { bg = "#504945"; };
      "ui.linenr"               = { fg = "#665c54"; };
      "ui.linenr.selected"      = { fg = "#fabd2f"; modifiers = ["bold"]; };
      "ui.popup"                = { bg = "#282828"; };
      "ui.window"               = { fg = "#504945"; };
      "ui.help"                 = { bg = "#282828"; fg = "#ebdbb2"; };
      "ui.menu"                 = { bg = "#282828"; fg = "#ebdbb2"; };
      "ui.menu.selected"        = { bg = "#504945"; fg = "#fabd2f"; modifiers = ["bold"]; };
      "ui.virtual.indent-guide" = { fg = "#3c3836"; };
      "ui.virtual.inlay-hint"   = { fg = "#928374"; };
      "ui.virtual.ruler"        = { bg = "#282828"; };
    };

    languages = {
      language-server = {
        rust-analyzer = {
          command = "rust-analyzer";
          config = {
            check.command     = "clippy";
            cargo.allFeatures = true;
            inlayHints = {
              bindingModeHints.enable          = true;
              closureCaptureHints.enable       = true;
              closureReturnTypeHints.enable    = "always";
              discriminantHints.enable         = "always";
              expressionAdjustmentHints.enable = "always";
              lifetimeElisionHints.enable      = "always";
              typeHints.enable                 = true;
            };
          };
        };
        clangd = {
          command = "clangd";
          args    = [ "--background-index" "--clang-tidy" "--completion-style=detailed" ];
        };
        jdtls    = { command = "${pkgs.jdt-language-server}/bin/jdtls"; };
        nixd     = { command = "nixd"; };
        marksman = { command = "marksman"; args = [ "server" ]; };
      };

      language = [
        { name = "rust";     auto-format = false; language-servers = [ "rust-analyzer" ]; }
        { name = "c";        auto-format = false; language-servers = [ "clangd" ]; }
        { name = "cpp";      auto-format = false; language-servers = [ "clangd" ]; }
        { name = "java";     auto-format = false; language-servers = [ "jdtls" ]; }
        { name = "nix";      auto-format = false; language-servers = [ "nixd" ]; }
        { name = "markdown"; auto-format = false; language-servers = [ "marksman" ]; }
        { name = "toml";     auto-format = false; }
      ];
    };
  };
}
