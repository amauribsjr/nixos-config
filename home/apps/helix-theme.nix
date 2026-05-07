{ ... }:

{
  xdg.configFile."helix/themes/koppi-theme.toml".text = ''
    "ui.background"           = { bg = "#2e2e2e" }
    "ui.background.separator" = { fg = "#535353" }

    "ui.statusline"           = { fg = "#e8e8e8", bg = "#383838" }
    "ui.statusline.inactive"  = { fg = "#646464", bg = "#2e2e2e" }
    "ui.statusline.normal"    = { fg = "#2e2e2e", bg = "#909090", modifiers = ["bold"] }
    "ui.statusline.insert"    = { fg = "#2e2e2e", bg = "#d4b048", modifiers = ["bold"] }
    "ui.statusline.select"    = { fg = "#2e2e2e", bg = "#e8c858", modifiers = ["bold"] }

    "ui.cursor.normal"        = { fg = "#2e2e2e", bg = "#f5f5f5" }
    "ui.cursor.insert"        = { fg = "#2e2e2e", bg = "#d4b048" }
    "ui.cursor.select"        = { fg = "#2e2e2e", bg = "#e8c858" }
    "ui.cursor.match"         = { fg = "#2e2e2e", bg = "#f0d060" }

    "ui.cursorline.primary"   = { bg = "#383838" }
    "ui.cursorline.secondary" = { bg = "#353535" }

    "ui.selection"            = { bg = "#434343" }
    "ui.selection.primary"    = { bg = "#4e4e4e" }

    "ui.linenr"               = { fg = "#4e4e4e" }
    "ui.linenr.selected"      = { fg = "#787878", modifiers = ["bold"] }

    "ui.popup"                = { bg = "#383838", fg = "#e8e8e8" }
    "ui.popup.info"           = { bg = "#383838", fg = "#e8e8e8" }
    "ui.window"               = { fg = "#535353" }
    "ui.help"                 = { bg = "#383838", fg = "#e8e8e8" }

    "ui.menu"                 = { bg = "#383838", fg = "#e8e8e8" }
    "ui.menu.selected"        = { bg = "#434343", fg = "#e8c858", modifiers = ["bold"] }
    "ui.menu.scroll"          = { fg = "#646464", bg = "#383838" }

    "ui.virtual.indent-guide" = { fg = "#3a3a3a" }
    "ui.virtual.inlay-hint"   = { fg = "#606060" }
    "ui.virtual.ruler"        = { bg = "#353535" }
    "ui.virtual.jump-label"   = { fg = "#f0d060", modifiers = ["bold"] }

    "ui.text"                 = { fg = "#e8e8e8" }
    "ui.text.focus"           = { fg = "#f5f5f5", modifiers = ["bold"] }
    "ui.text.info"            = { fg = "#909090" }

    "ui.highlight"            = { bg = "#434343" }
    "ui.highlight.frameline"  = { bg = "#383838" }

    "warning"            = { fg = "#c4924a" }
    "error"              = { fg = "#c45a5a" }
    "info"               = { fg = "#909090" }
    "hint"               = { fg = "#787878" }

    "diagnostic.warning" = { underline = { color = "#c4924a", style = "curl" } }
    "diagnostic.error"   = { underline = { color = "#c45a5a", style = "curl" } }
    "diagnostic.info"    = { underline = { color = "#909090", style = "dotted" } }
    "diagnostic.hint"    = { underline = { color = "#787878", style = "dotted" } }

    "diff.plus"        = { fg = "#6aa07a" }
    "diff.minus"       = { fg = "#c45a5a" }
    "diff.delta"       = { fg = "#c4924a" }
    "diff.delta.moved" = { fg = "#909090" }

    "comment"                     = { fg = "#787878" }
    "comment.line"                = { fg = "#787878" }
    "comment.block"               = { fg = "#787878" }
    "comment.block.documentation" = { fg = "#909090" }

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

    "variable"              = { fg = "#e8e8e8" }
    "variable.builtin"      = { fg = "#d4b048" }
    "variable.parameter"    = { fg = "#e8e8e8" }
    "variable.other"        = { fg = "#e8e8e8" }
    "variable.other.member" = { fg = "#e8e8e8" }

    "type"              = { fg = "#d4b048" }
    "type.builtin"      = { fg = "#d4b048" }
    "type.enum"         = { fg = "#d4b048" }
    "type.enum.variant" = { fg = "#e8c858" }
    "type.parameter"    = { fg = "#d4b048" }

    "constructor" = { fg = "#e8c858" }

    "function"         = { fg = "#f5f5f5" }
    "function.builtin" = { fg = "#909090" }
    "function.method"  = { fg = "#f5f5f5" }
    "function.macro"   = { fg = "#e8c858" }
    "function.special" = { fg = "#e8c858" }

    "namespace" = { fg = "#e8e8e8" }
    "module"    = { fg = "#e8e8e8" }

    "constant"                  = { fg = "#e8c858" }
    "constant.builtin"          = { fg = "#e8c858", modifiers = ["bold"] }
    "constant.character"        = { fg = "#d4b048" }
    "constant.character.escape" = { fg = "#f0d060" }
    "constant.numeric"          = { fg = "#f0d060" }
    "constant.numeric.integer"  = { fg = "#f0d060" }
    "constant.numeric.float"    = { fg = "#f0d060" }

    "string"             = { fg = "#d4b048" }
    "string.regexp"      = { fg = "#f0d060" }
    "string.special"     = { fg = "#f0d060" }
    "string.special.url" = { fg = "#909090", modifiers = ["underlined"] }

    "attribute"         = { fg = "#707070" }
    "attribute.builtin" = { fg = "#707070" }

    "label"   = { fg = "#d4b048" }
    "special" = { fg = "#e8c858" }

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