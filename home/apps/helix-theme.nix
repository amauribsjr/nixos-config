{ ... }:

{
  xdg.configFile."helix/themes/koppi-theme.toml".text = ''
    "ui.background"           = { bg = "#111111" }
    "ui.background.separator" = { fg = "#383838" }
    "ui.statusline"           = { fg = "#d0d0d0", bg = "#1c1c1c" }
    "ui.statusline.inactive"  = { fg = "#6b6b6b", bg = "#111111" }
    "ui.statusline.normal"    = { fg = "#111111", bg = "#8a8a8a", modifiers = ["bold"] }
    "ui.statusline.insert"    = { fg = "#111111", bg = "#d4b048", modifiers = ["bold"] }
    "ui.statusline.select"    = { fg = "#111111", bg = "#cdb87a", modifiers = ["bold"] }
    "ui.cursor.normal"        = { fg = "#111111", bg = "#f0f0f0" }
    "ui.cursor.insert"        = { fg = "#111111", bg = "#d4b048" }
    "ui.cursor.select"        = { fg = "#111111", bg = "#cdb87a" }
    "ui.cursor.match"         = { fg = "#111111", bg = "#e8c858" }
    "ui.cursorline.primary"   = { bg = "#1c1c1c" }
    "ui.cursorline.secondary" = { bg = "#1c1c1c" }
    "ui.selection"            = { bg = "#272727" }
    "ui.selection.primary"    = { bg = "#383838" }
    "ui.linenr"               = { fg = "#383838" }
    "ui.linenr.selected"      = { fg = "#6b6b6b", modifiers = ["bold"] }
    "ui.popup"                = { bg = "#1c1c1c", fg = "#d0d0d0" }
    "ui.popup.info"           = { bg = "#1c1c1c", fg = "#d0d0d0" }
    "ui.window"               = { fg = "#383838" }
    "ui.help"                 = { bg = "#1c1c1c", fg = "#d0d0d0" }
    "ui.menu"                 = { bg = "#1c1c1c", fg = "#d0d0d0" }
    "ui.menu.selected"        = { bg = "#272727", fg = "#cdb87a", modifiers = ["bold"] }
    "ui.menu.scroll"          = { fg = "#4a4a4a", bg = "#1c1c1c" }
    "ui.virtual.indent-guide" = { fg = "#272727" }
    "ui.virtual.inlay-hint"   = { fg = "#4a4a4a" }
    "ui.virtual.ruler"        = { bg = "#1c1c1c" }
    "ui.virtual.jump-label"   = { fg = "#e8c858", modifiers = ["bold"] }
    "ui.text"                 = { fg = "#d0d0d0" }
    "ui.text.focus"           = { fg = "#f0f0f0", modifiers = ["bold"] }
    "ui.highlight"            = { bg = "#272727" }

    "warning"            = { fg = "#c4924a" }
    "error"              = { fg = "#b54a4a" }
    "info"               = { fg = "#8a8a8a" }
    "hint"               = { fg = "#6b6b6b" }
    "diagnostic.warning" = { underline = { color = "#c4924a", style = "curl" } }
    "diagnostic.error"   = { underline = { color = "#b54a4a", style = "curl" } }
    "diagnostic.info"    = { underline = { color = "#8a8a8a", style = "dotted" } }
    "diagnostic.hint"    = { underline = { color = "#6b6b6b", style = "dotted" } }

    "diff.plus"  = { fg = "#5a8f6a" }
    "diff.minus" = { fg = "#b54a4a" }
    "diff.delta" = { fg = "#c4924a" }

    "comment"                     = { fg = "#6b6b6b", modifiers = ["italic"] }
    "comment.block.documentation" = { fg = "#8a8a8a", modifiers = ["italic"] }

    "keyword"                  = { fg = "#f0f0f0", modifiers = ["bold"] }
    "keyword.operator"         = { fg = "#d0d0d0" }
    "keyword.directive"        = { fg = "#cdb87a" }
    "keyword.storage.modifier" = { fg = "#d0d0d0" }
    "operator"                 = { fg = "#d0d0d0" }

    "punctuation"           = { fg = "#6b6b6b" }
    "punctuation.bracket"   = { fg = "#6b6b6b" }
    "punctuation.delimiter" = { fg = "#6b6b6b" }
    "punctuation.special"   = { fg = "#8a8a8a" }

    "variable"           = { fg = "#d0d0d0" }
    "variable.builtin"   = { fg = "#cdb87a" }
    "variable.parameter" = { fg = "#d0d0d0", modifiers = ["italic"] }

    "type"              = { fg = "#cdb87a" }
    "type.builtin"      = { fg = "#cdb87a" }
    "type.enum.variant" = { fg = "#d4b048" }
    "type.parameter"    = { fg = "#cdb87a", modifiers = ["italic"] }
    "constructor"       = { fg = "#d4b048" }

    "function"         = { fg = "#f0f0f0" }
    "function.builtin" = { fg = "#8a8a8a" }
    "function.method"  = { fg = "#f0f0f0" }
    "function.macro"   = { fg = "#d4b048" }

    "namespace" = { fg = "#d0d0d0" }

    "constant"                  = { fg = "#d4b048" }
    "constant.builtin"          = { fg = "#d4b048", modifiers = ["bold"] }
    "constant.character"        = { fg = "#cdb87a" }
    "constant.character.escape" = { fg = "#e8c858" }
    "constant.numeric"          = { fg = "#e8c858" }

    "string"             = { fg = "#cdb87a" }
    "string.regexp"      = { fg = "#e8c858" }
    "string.special"     = { fg = "#e8c858" }
    "string.special.url" = { fg = "#8a8a8a", modifiers = ["underlined"] }

    "attribute" = { fg = "#6b6b6b" }
    "label"     = { fg = "#cdb87a" }

    "markup.heading"   = { fg = "#f0f0f0", modifiers = ["bold"] }
    "markup.heading.2" = { fg = "#d0d0d0", modifiers = ["bold"] }
    "markup.heading.3" = { fg = "#cdb87a", modifiers = ["bold"] }
    "markup.link.url"  = { fg = "#8a8a8a", modifiers = ["underlined"] }
    "markup.link.text" = { fg = "#cdb87a" }
    "markup.raw"       = { fg = "#d4b048" }
  '';
}
