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
      theme = "gruvbox_dark_hard";

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
}
