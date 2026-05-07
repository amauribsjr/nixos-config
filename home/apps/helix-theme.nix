{ colors, ... }:

{
  xdg.configFile."helix/themes/koppi-theme.toml".text = ''
    "ui.background"           = { bg = "#${colors.bg}" }
    "ui.background.separator" = { fg = "#${colors.bg3}" }

    "ui.statusline"           = { fg = "#${colors.fg}", bg = "#${colors.bg1}" }
    "ui.statusline.inactive"  = { fg = "#${colors.bg4}", bg = "#${colors.bg}" }
    "ui.statusline.normal"    = { fg = "#${colors.bg}", bg = "#${colors.fgMuted}", modifiers = ["bold"] }
    "ui.statusline.insert"    = { fg = "#${colors.bg}", bg = "#${colors.accent}", modifiers = ["bold"] }
    "ui.statusline.select"    = { fg = "#${colors.bg}", bg = "#${colors.accbrt}", modifiers = ["bold"] }

    "ui.cursor.normal"        = { fg = "#${colors.bg}", bg = "#${colors.bwhite}" }
    "ui.cursor.insert"        = { fg = "#${colors.bg}", bg = "#${colors.accent}" }
    "ui.cursor.select"        = { fg = "#${colors.bg}", bg = "#${colors.accbrt}" }
    "ui.cursor.match"         = { fg = "#${colors.bg}", bg = "#${colors.acchigh}" }

    "ui.cursorline.primary"   = { bg = "#${colors.bg1}" }
    "ui.cursorline.secondary" = { bg = "#${colors.bgLine}" }

    "ui.selection"            = { bg = "#${colors.bg2}" }
    "ui.selection.primary"    = { bg = "#${colors.bgSelect}" }

    "ui.linenr"               = { fg = "#${colors.bgSelect}" }
    "ui.linenr.selected"      = { fg = "#${colors.fg2}", modifiers = ["bold"] }

    "ui.popup"                = { bg = "#${colors.bg1}", fg = "#${colors.fg}" }
    "ui.popup.info"           = { bg = "#${colors.bg1}", fg = "#${colors.fg}" }
    "ui.window"               = { fg = "#${colors.bg3}" }
    "ui.help"                 = { bg = "#${colors.bg1}", fg = "#${colors.fg}" }

    "ui.menu"                 = { bg = "#${colors.bg1}", fg = "#${colors.fg}" }
    "ui.menu.selected"        = { bg = "#${colors.bg2}", fg = "#${colors.accbrt}", modifiers = ["bold"] }
    "ui.menu.scroll"          = { fg = "#${colors.bg4}", bg = "#${colors.bg1}" }

    "ui.virtual.indent-guide" = { fg = "#${colors.bgIndent}" }
    "ui.virtual.inlay-hint"   = { fg = "#${colors.fgHint}" }
    "ui.virtual.ruler"        = { bg = "#${colors.bgLine}" }
    "ui.virtual.jump-label"   = { fg = "#${colors.acchigh}", modifiers = ["bold"] }

    "ui.text"                 = { fg = "#${colors.fg}" }
    "ui.text.focus"           = { fg = "#${colors.bwhite}", modifiers = ["bold"] }
    "ui.text.info"            = { fg = "#${colors.fgMuted}" }

    "ui.highlight"            = { bg = "#${colors.bg2}" }
    "ui.highlight.frameline"  = { bg = "#${colors.bg1}" }

    "warning"            = { fg = "#${colors.warning}" }
    "error"              = { fg = "#${colors.bred}" }
    "info"               = { fg = "#${colors.fgMuted}" }
    "hint"               = { fg = "#${colors.fg2}" }

    "diagnostic.warning" = { underline = { color = "#${colors.warning}", style = "curl" } }
    "diagnostic.error"   = { underline = { color = "#${colors.bred}", style = "curl" } }
    "diagnostic.info"    = { underline = { color = "#${colors.fgMuted}", style = "dotted" } }
    "diagnostic.hint"    = { underline = { color = "#${colors.fg2}", style = "dotted" } }

    "diff.plus"        = { fg = "#${colors.bgreen}" }
    "diff.minus"       = { fg = "#${colors.bred}" }
    "diff.delta"       = { fg = "#${colors.warning}" }
    "diff.delta.moved" = { fg = "#${colors.fgMuted}" }

    "comment"                     = { fg = "#${colors.fg2}" }
    "comment.line"                = { fg = "#${colors.fg2}" }
    "comment.block"               = { fg = "#${colors.fg2}" }
    "comment.block.documentation" = { fg = "#${colors.fgMuted}" }

    "keyword"                   = { fg = "#${colors.bwhite}", modifiers = ["bold"] }
    "keyword.control"           = { fg = "#${colors.bwhite}", modifiers = ["bold"] }
    "keyword.control.return"    = { fg = "#${colors.bwhite}", modifiers = ["bold"] }
    "keyword.control.import"    = { fg = "#${colors.bwhite}", modifiers = ["bold"] }
    "keyword.function"          = { fg = "#${colors.bwhite}", modifiers = ["bold"] }
    "keyword.storage"           = { fg = "#${colors.bwhite}", modifiers = ["bold"] }
    "keyword.storage.type"      = { fg = "#${colors.bwhite}", modifiers = ["bold"] }
    "keyword.storage.modifier"  = { fg = "#${colors.fg}" }
    "keyword.operator"          = { fg = "#${colors.fg}" }
    "keyword.directive"         = { fg = "#${colors.accent}" }

    "operator" = { fg = "#${colors.fg}" }

    "punctuation"           = { fg = "#${colors.fgSubtle}" }
    "punctuation.bracket"   = { fg = "#${colors.fgSubtle}" }
    "punctuation.delimiter" = { fg = "#${colors.fgSubtle}" }
    "punctuation.special"   = { fg = "#${colors.fgMuted}" }

    "variable"              = { fg = "#${colors.fg}" }
    "variable.builtin"      = { fg = "#${colors.accent}" }
    "variable.parameter"    = { fg = "#${colors.fg}" }
    "variable.other"        = { fg = "#${colors.fg}" }
    "variable.other.member" = { fg = "#${colors.fg}" }

    "type"              = { fg = "#${colors.accent}" }
    "type.builtin"      = { fg = "#${colors.accent}" }
    "type.enum"         = { fg = "#${colors.accent}" }
    "type.enum.variant" = { fg = "#${colors.accbrt}" }
    "type.parameter"    = { fg = "#${colors.accent}" }

    "constructor" = { fg = "#${colors.accbrt}" }

    "function"         = { fg = "#${colors.bwhite}" }
    "function.builtin" = { fg = "#${colors.fgMuted}" }
    "function.method"  = { fg = "#${colors.bwhite}" }
    "function.macro"   = { fg = "#${colors.accbrt}" }
    "function.special" = { fg = "#${colors.accbrt}" }

    "namespace" = { fg = "#${colors.fg}" }
    "module"    = { fg = "#${colors.fg}" }

    "constant"                  = { fg = "#${colors.accbrt}" }
    "constant.builtin"          = { fg = "#${colors.accbrt}", modifiers = ["bold"] }
    "constant.character"        = { fg = "#${colors.accent}" }
    "constant.character.escape" = { fg = "#${colors.acchigh}" }
    "constant.numeric"          = { fg = "#${colors.acchigh}" }
    "constant.numeric.integer"  = { fg = "#${colors.acchigh}" }
    "constant.numeric.float"    = { fg = "#${colors.acchigh}" }

    "string"             = { fg = "#${colors.accent}" }
    "string.regexp"      = { fg = "#${colors.acchigh}" }
    "string.special"     = { fg = "#${colors.acchigh}" }
    "string.special.url" = { fg = "#${colors.fgMuted}", modifiers = ["underlined"] }

    "attribute"         = { fg = "#${colors.fgSubtle}" }
    "attribute.builtin" = { fg = "#${colors.fgSubtle}" }

    "label"   = { fg = "#${colors.accent}" }
    "special" = { fg = "#${colors.accbrt}" }

    "markup.heading"         = { fg = "#${colors.bwhite}", modifiers = ["bold"] }
    "markup.heading.1"       = { fg = "#${colors.bwhite}", modifiers = ["bold"] }
    "markup.heading.2"       = { fg = "#${colors.fg}", modifiers = ["bold"] }
    "markup.heading.3"       = { fg = "#${colors.accent}", modifiers = ["bold"] }
    "markup.heading.4"       = { fg = "#${colors.accent}" }
    "markup.heading.5"       = { fg = "#${colors.fgMuted}" }
    "markup.bold"            = { modifiers = ["bold"] }
    "markup.italic"          = { modifiers = ["italic"] }
    "markup.strikethrough"   = { modifiers = ["crossed_out"] }
    "markup.link.url"        = { fg = "#${colors.fgMuted}", modifiers = ["underlined"] }
    "markup.link.text"       = { fg = "#${colors.accent}" }
    "markup.raw"             = { fg = "#${colors.accbrt}" }
    "markup.raw.inline"      = { fg = "#${colors.accbrt}" }
    "markup.list"            = { fg = "#${colors.fg}" }
  '';
}