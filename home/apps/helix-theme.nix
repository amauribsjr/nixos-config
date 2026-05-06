{ ... }:

{
  xdg.configFile."helix/themes/koppi-theme.toml".text = ''
    "ui.background"           = { bg = "#1a1a1a" }
    "ui.background.separator" = { fg = "#404040" }
    "ui.statusline"           = { fg = "#e8e8e8", bg = "#252525" }
    "ui.statusline.inactive"  = { fg = "#6b6b6b", bg = "#1a1a1a" }
    "ui.statusline.normal"    = { fg = "#1a1a1a", bg = "#909090", modifiers = ["bold"] }
    "ui.statusline.insert"    = { fg = "#1a1a1a", bg = "#d4b048", modifiers = ["bold"] }
    "ui.statusline.select"    = { fg = "#1a1a1a", bg = "#cdb87a", modifiers = ["bold"] }
    "ui.cursor.normal"        = { fg = "#1a1a1a", bg = "#f5f5f5" }
    "ui.cursor.insert"        = { fg = "#1a1a1a", bg = "#d4b048" }
    "ui.cursor.select"        = { fg = "#1a1a1a", bg = "#cdb87a" }
    "ui.cursor.match"         = { fg = "#1a1a1a", bg = "#e8c858" }
    "ui.cursorline.primary"   = { bg = "#252525" }
    "ui.cursorline.secondary" = { bg = "#252525" }
    "ui.selection"            = { bg = "#303030" }
    "ui.selection.primary"    = { bg = "#404040" }
    "ui.linenr"               = { fg = "#404040" }
    "ui.linenr.selected"      = { fg = "#707070", modifiers = ["bold"] }
    "ui.popup"                = { bg = "#252525", fg = "#e8e8e8" }
    "ui.popup.info"           = { bg = "#252525", fg = "#e8e8e8" }
    "ui.window"               = { fg = "#404040" }
    "ui.help"                 = { bg = "#252525", fg = "#e8e8e8" }
    "ui.menu"                 = { bg = "#252525", fg = "#e8e8e8" }
    "ui.menu.selected"        = { bg = "#303030", fg = "#cdb87a", modifiers = ["bold"] }
    "ui.menu.scroll"          = { fg = "#525252", bg = "#252525" }
    "ui.virtual.indent-guide" = { fg = "#2e2e2e" }
    "ui.virtual.inlay-hint"   = { fg = "#525252" }
    "ui.virtual.ruler"        = { bg = "#252525" }
    "ui.virtual.jump-label"   = { fg = "#e8c858", modifiers = ["bold"] }
    "ui.text"                 = { fg = "#e8e8e8" }
    "ui.text.focus"           = { fg = "#f5f5f5", modifiers = ["bold"] }
    "ui.highlight"            = { bg = "#303030" }

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

    "keyword"                  = { fg = "#f5f5f5", modifiers = ["bold"] }
    "keyword.operator"         = { fg = "#e8e8e8" }
    "keyword.directive"        = { fg = "#cdb87a" }
    "keyword.storage.modifier" = { fg = "#e8e8e8" }
    "operator"                 = { fg = "#e8e8e8" }

    "punctuation"           = { fg = "#707070" }
    "punctuation.bracket"   = { fg = "#707070" }
    "punctuation.delimiter" = { fg = "#707070" }
    "punctuation.special"   = { fg = "#909090" }

    "variable"           = { fg = "#e8e8e8" }
    "variable.builtin"   = { fg = "#cdb87a" }
    "variable.parameter" = { fg = "#e8e8e8", modifiers = ["italic"] }

    "type"              = { fg = "#cdb87a" }
    "type.builtin"      = { fg = "#cdb87a" }
    "type.enum.variant" = { fg = "#d4b048" }
    "type.parameter"    = { fg = "#cdb87a", modifiers = ["italic"] }
    "constructor"       = { fg = "#d4b048" }

    "function"         = { fg = "#f5f5f5" }
    "function.builtin" = { fg = "#909090" }
    "function.method"  = { fg = "#f5f5f5" }
    "function.macro"   = { fg = "#d4b048" }

    "namespace" = { fg = "#e8e8e8" }

    "constant"                  = { fg = "#d4b048" }
    "constant.builtin"          = { fg = "#d4b048", modifiers = ["bold"] }
    "constant.character"        = { fg = "#cdb87a" }
    "constant.character.escape" = { fg = "#e8c858" }
    "constant.numeric"          = { fg = "#e8c858" }

    "string"             = { fg = "#cdb87a" }
    "string.regexp"      = { fg = "#e8c858" }
    "string.special"     = { fg = "#e8c858" }
    "string.special.url" = { fg = "#909090", modifiers = ["underlined"] }

    "attribute" = { fg = "#707070" }
    "label"     = { fg = "#cdb87a" }

    "markup.heading"   = { fg = "#f5f5f5", modifiers = ["bold"] }
    "markup.heading.2" = { fg = "#e8e8e8", modifiers = ["bold"] }
    "markup.heading.3" = { fg = "#cdb87a", modifiers = ["bold"] }
    "markup.link.url"  = { fg = "#909090", modifiers = ["underlined"] }
    "markup.link.text" = { fg = "#cdb87a" }
    "markup.raw"       = { fg = "#d4b048" }
  '';
}