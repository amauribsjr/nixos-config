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
      theme = "koppi-theme";

      editor = {
        line-number  = "relative";
        cursorline   = true;
        color-modes  = true;
        scroll-lines = 3;
        shell        = [ "bash" "-c" ];
        rulers       = [ 100 ];
        bufferline   = "multiple";
        auto-format  = false;

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
          cursor-line = "warning";
          other-lines = "error";
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

    themes.koppi-theme = {
      "ui.background"           = { bg = "#111111"; };
      "ui.background.separator" = { fg = "#383838"; };
      "ui.statusline"           = { fg = "#d0d0d0"; bg = "#1c1c1c"; };
      "ui.statusline.inactive"  = { fg = "#6b6b6b"; bg = "#111111"; };
      "ui.statusline.normal"    = { fg = "#111111"; bg = "#8a8a8a"; modifiers = ["bold"]; };
      "ui.statusline.insert"    = { fg = "#111111"; bg = "#d97756"; modifiers = ["bold"]; };
      "ui.statusline.select"    = { fg = "#111111"; bg = "#c4a07a"; modifiers = ["bold"]; };
      "ui.cursor.normal"        = { fg = "#111111"; bg = "#f0f0f0"; };
      "ui.cursor.insert"        = { fg = "#111111"; bg = "#d97756"; };
      "ui.cursor.select"        = { fg = "#111111"; bg = "#c4a07a"; };
      "ui.cursor.match"         = { fg = "#111111"; bg = "#e8935a"; };
      "ui.cursorline.primary"   = { bg = "#1c1c1c"; };
      "ui.cursorline.secondary" = { bg = "#1c1c1c"; };
      "ui.selection"            = { bg = "#272727"; };
      "ui.selection.primary"    = { bg = "#383838"; };
      "ui.linenr"               = { fg = "#383838"; };
      "ui.linenr.selected"      = { fg = "#6b6b6b"; modifiers = ["bold"]; };
      "ui.popup"                = { bg = "#1c1c1c"; fg = "#d0d0d0"; };
      "ui.popup.info"           = { bg = "#1c1c1c"; fg = "#d0d0d0"; };
      "ui.window"               = { fg = "#383838"; };
      "ui.help"                 = { bg = "#1c1c1c"; fg = "#d0d0d0"; };
      "ui.menu"                 = { bg = "#1c1c1c"; fg = "#d0d0d0"; };
      "ui.menu.selected"        = { bg = "#272727"; fg = "#c4a07a"; modifiers = ["bold"]; };
      "ui.menu.scroll"          = { fg = "#4a4a4a"; bg = "#1c1c1c"; };
      "ui.virtual.indent-guide" = { fg = "#272727"; };
      "ui.virtual.inlay-hint"   = { fg = "#4a4a4a"; };
      "ui.virtual.ruler"        = { bg = "#1c1c1c"; };
      "ui.virtual.jump-label"   = { fg = "#e8935a"; modifiers = ["bold"]; };
      "ui.text"                 = { fg = "#d0d0d0"; };
      "ui.text.focus"           = { fg = "#f0f0f0"; modifiers = ["bold"]; };
      "ui.highlight"            = { bg = "#272727"; };

      "warning"            = { fg = "#c4924a"; };
      "error"              = { fg = "#b54a4a"; };
      "info"               = { fg = "#8a8a8a"; };
      "hint"               = { fg = "#6b6b6b"; };
      "diagnostic.warning" = { underline = { color = "#c4924a"; style = "curl"; }; };
      "diagnostic.error"   = { underline = { color = "#b54a4a"; style = "curl"; }; };
      "diagnostic.info"    = { underline = { color = "#8a8a8a"; style = "dotted"; }; };
      "diagnostic.hint"    = { underline = { color = "#6b6b6b"; style = "dotted"; }; };

      "diff.plus"          = { fg = "#5a8f6a"; };
      "diff.minus"         = { fg = "#b54a4a"; };
      "diff.delta"         = { fg = "#c4924a"; };

      "comment"                     = { fg = "#6b6b6b"; modifiers = ["italic"]; };
      "comment.block.documentation" = { fg = "#8a8a8a"; modifiers = ["italic"]; };

      "keyword"                  = { fg = "#f0f0f0"; modifiers = ["bold"]; };
      "keyword.operator"         = { fg = "#d0d0d0"; };
      "keyword.directive"        = { fg = "#c4a07a"; };
      "keyword.storage.modifier" = { fg = "#d0d0d0"; };
      "operator"                 = { fg = "#d0d0d0"; };

      "punctuation"          = { fg = "#6b6b6b"; };
      "punctuation.bracket"  = { fg = "#6b6b6b"; };
      "punctuation.delimiter"= { fg = "#6b6b6b"; };
      "punctuation.special"  = { fg = "#8a8a8a"; };

      "variable"           = { fg = "#d0d0d0"; };
      "variable.builtin"   = { fg = "#c4a07a"; };
      "variable.parameter" = { fg = "#d0d0d0"; modifiers = ["italic"]; };

      "type"               = { fg = "#c4a07a"; };
      "type.builtin"       = { fg = "#c4a07a"; };
      "type.enum.variant"  = { fg = "#d97756"; };
      "type.parameter"     = { fg = "#c4a07a"; modifiers = ["italic"]; };
      "constructor"        = { fg = "#d97756"; };

      "function"           = { fg = "#f0f0f0"; };
      "function.builtin"   = { fg = "#8a8a8a"; };
      "function.method"    = { fg = "#f0f0f0"; };
      "function.macro"     = { fg = "#d97756"; };

      "namespace"          = { fg = "#d0d0d0"; };

      "constant"                  = { fg = "#d97756"; };
      "constant.builtin"          = { fg = "#d97756"; modifiers = ["bold"]; };
      "constant.character"        = { fg = "#c4a07a"; };
      "constant.character.escape" = { fg = "#e8935a"; };
      "constant.numeric"          = { fg = "#e8935a"; };

      "string"             = { fg = "#c4a07a"; };
      "string.regexp"      = { fg = "#e8935a"; };
      "string.special"     = { fg = "#e8935a"; };
      "string.special.url" = { fg = "#8a8a8a"; modifiers = ["underlined"]; };

      "attribute"          = { fg = "#6b6b6b"; };
      "label"              = { fg = "#c4a07a"; };

      "markup.heading"     = { fg = "#f0f0f0"; modifiers = ["bold"]; };
      "markup.heading.2"   = { fg = "#d0d0d0"; modifiers = ["bold"]; };
      "markup.heading.3"   = { fg = "#c4a07a"; modifiers = ["bold"]; };
      "markup.link.url"    = { fg = "#8a8a8a"; modifiers = ["underlined"]; };
      "markup.link.text"   = { fg = "#c4a07a"; };
      "markup.raw"         = { fg = "#d97756"; };
    };

    languages = {
      language-server = {
        rust-analyzer = {
          command = "rust-analyzer";
          config = {
            check.command = "check";
            cargo.allFeatures = false;
            inlayHints.typeHints.enable = true;
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

  xdg.desktopEntries.helix = {
    name        = "Helix";
    genericName = "Helix TUI Code Editor";
    exec        = "kitty -e hx %F";
    terminal    = false;
    categories  = [ "Utility" "TextEditor" ];
    mimeType    = [
      "text/plain"
      "text/x-readme"
      "text/markdown"
      "text/x-rust"
      "text/x-c"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "application/toml"
      "application/json"
      "application/x-nix"
    ];
  };
  home.file.".local/share/applications/Helix.desktop".text = ''
    [Desktop Entry]
    Type=Application
    NoDisplay=true
  '';
}
