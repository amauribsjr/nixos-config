{ ... }:

{
  xdg.configFile."helix/themes/koppi-theme.toml".text = ''
    # UI Shell

    "ui.background"           = { bg = "#1a1a1a" }
    "ui.background.separator" = { fg = "#404040" }

    "ui.statusline"           = { fg = "#e8e8e8", bg = "#252525" }
    "ui.statusline.inactive"  = { fg = "#525252", bg = "#1a1a1a" }
    "ui.statusline.normal"    = { fg = "#1a1a1a", bg = "#909090", modifiers = ["bold"] }
    "ui.statusline.insert"    = { fg = "#1a1a1a", bg = "#d4b048", modifiers = ["bold"] }
    "ui.statusline.select"    = { fg = "#1a1a1a", bg = "#e8c858", modifiers = ["bold"] }

    "ui.cursor.normal"        = { fg = "#1a1a1a", bg = "#f5f5f5" }
    "ui.cursor.insert"        = { fg = "#1a1a1a", bg = "#d4b048" }
    "ui.cursor.select"        = { fg = "#1a1a1a", bg = "#e8c858" }
    "ui.cursor.match"         = { fg = "#1a1a1a", bg = "#f0d060" }

    "ui.cursorline.primary"   = { bg = "#252525" }
    "ui.cursorline.secondary" = { bg = "#222222" }

    "ui.selection"            = { bg = "#303030" }
    "ui.selection.primary"    = { bg = "#3a3a3a" }

    "ui.linenr"               = { fg = "#3a3a3a" }
    "ui.linenr.selected"      = { fg = "#707070", modifiers = ["bold"] }

    "ui.popup"                = { bg = "#252525", fg = "#e8e8e8" }
    "ui.popup.info"           = { bg = "#252525", fg = "#e8e8e8" }
    "ui.window"               = { fg = "#404040" }
    "ui.help"                 = { bg = "#252525", fg = "#e8e8e8" }

    "ui.menu"                 = { bg = "#252525", fg = "#e8e8e8" }
    "ui.menu.selected"        = { bg = "#303030", fg = "#e8c858", modifiers = ["bold"] }
    "ui.menu.scroll"          = { fg = "#525252", bg = "#252525" }

    "ui.virtual.indent-guide" = { fg = "#2a2a2a" }
    "ui.virtual.inlay-hint"   = { fg = "#505050" }
    "ui.virtual.ruler"        = { bg = "#222222" }
    "ui.virtual.jump-label"   = { fg = "#f0d060", modifiers = ["bold"] }

    "ui.text"                 = { fg = "#e8e8e8" }
    "ui.text.focus"           = { fg = "#f5f5f5", modifiers = ["bold"] }
    "ui.text.info"            = { fg = "#909090" }

    "ui.highlight"            = { bg = "#303030" }
    "ui.highlight.frameline"  = { bg = "#252525" }

    # Diagnostics

    "warning"            = { fg = "#c4924a" }
    "error"              = { fg = "#c45a5a" }
    "info"               = { fg = "#909090" }
    "hint"               = { fg = "#6b6b6b" }

    "diagnostic.warning" = { underline = { color = "#c4924a", style = "curl" } }
    "diagnostic.error"   = { underline = { color = "#c45a5a", style = "curl" } }
    "diagnostic.info"    = { underline = { color = "#909090", style = "dotted" } }
    "diagnostic.hint"    = { underline = { color = "#6b6b6b", style = "dotted" } }

    # Diff

    "diff.plus"        = { fg = "#6aa07a" }
    "diff.minus"       = { fg = "#c45a5a" }
    "diff.delta"       = { fg = "#c4924a" }
    "diff.delta.moved" = { fg = "#909090" }

    # Syntax

    "comment"                     = { fg = "#6b6b6b", modifiers = ["italic"] }
    "comment.line"                = { fg = "#6b6b6b", modifiers = ["italic"] }
    "comment.block"               = { fg = "#6b6b6b", modifiers = ["italic"] }
    "comment.block.documentation" = { fg = "#909090", modifiers = ["italic"] }

    "keyword"                   = { fg = "#f5f5f5", modifiers = ["bold"] }
    "keyword.control"           = { fg = "#f5f5f5", modifiers = ["bold"] }
    "keyword.control.return"    = { fg = "#f5f5f5", modifiers = ["bold"] }
    "keyword.control.import"    = { fg = "#f5f5f5", modifiers = ["bold"] }
    "keyword.function"          = { fg = "#f5f5f5", modifiers = ["bold"] }
    "keyword.storage"           = { fg = "#f5f5f5", modifiers = ["bold"] }
    "keyword.storage.type"      = { fg = "#f5f5f5", modifiers = ["bold"] }
    "keyword.storage.modifier"  = { fg = "#e8e8e8" }
    "keyword.operator"          = { fg = "#e8e8e8" }
    "keyword.directive"         = { fg = "#d4b048" }

    "operator" = { fg = "#e8e8e8" }

    "punctuation"           = { fg = "#707070" }
    "punctuation.bracket"   = { fg = "#707070" }
    "punctuation.delimiter" = { fg = "#707070" }
    "punctuation.special"   = { fg = "#909090" }

    "variable"             = { fg = "#e8e8e8" }
    "variable.builtin"     = { fg = "#d4b048" }
    "variable.parameter"   = { fg = "#e8e8e8", modifiers = ["italic"] }
    "variable.other"       = { fg = "#e8e8e8" }
    "variable.other.member"= { fg = "#e8e8e8" }

    "type"              = { fg = "#d4b048" }
    "type.builtin"      = { fg = "#d4b048" }
    "type.enum"         = { fg = "#d4b048" }
    "type.enum.variant" = { fg = "#e8c858" }
    "type.parameter"    = { fg = "#d4b048", modifiers = ["italic"] }

    "constructor" = { fg = "#e8c858" }

    "function"          = { fg = "#f5f5f5" }
    "function.builtin"  = { fg = "#909090" }
    "function.method"   = { fg = "#f5f5f5" }
    "function.macro"    = { fg = "#e8c858" }
    "function.special"  = { fg = "#e8c858" }

    "namespace" = { fg = "#e8e8e8" }
    "module"    = { fg = "#e8e8e8" }

    "constant"                  = { fg = "#e8c858" }
    "constant.builtin"          = { fg = "#e8c858", modifiers = ["bold"] }
    "constant.character"        = { fg = "#d4b048" }
    "constant.character.escape" = { fg = "#f0d060" }
    "constant.numeric"          = { fg = "#f0d060" }
    "constant.numeric.integer"  = { fg = "#f0d060" }
    "constant.numeric.float"    = { fg = "#f0d060" }

    "string"               = { fg = "#d4b048" }
    "string.regexp"        = { fg = "#f0d060" }
    "string.special"       = { fg = "#f0d060" }
    "string.special.url"   = { fg = "#909090", modifiers = ["underlined"] }

    "attribute"         = { fg = "#707070" }
    "attribute.builtin" = { fg = "#707070" }

    "label"   = { fg = "#d4b048" }
    "special" = { fg = "#e8c858" }

    # Markup

    "markup.heading"         = { fg = "#f5f5f5", modifiers = ["bold"] }
    "markup.heading.1"       = { fg = "#f5f5f5", modifiers = ["bold"] }
    "markup.heading.2"       = { fg = "#e8e8e8", modifiers = ["bold"] }
    "markup.heading.3"       = { fg = "#d4b048", modifiers = ["bold"] }
    "markup.heading.4"       = { fg = "#d4b048" }
    "markup.heading.5"       = { fg = "#909090" }
    "markup.bold"            = { modifiers = ["bold"] }
    "markup.italic"          = { modifiers = ["italic"] }
    "markup.strikethrough"   = { modifiers = ["crossed_out"] }
    "markup.link.url"        = { fg = "#909090", modifiers = ["underlined"] }
    "markup.link.text"       = { fg = "#d4b048" }
    "markup.raw"             = { fg = "#e8c858" }
    "markup.raw.inline"      = { fg = "#e8c858" }
    "markup.list"            = { fg = "#e8e8e8" }
  '';
}
