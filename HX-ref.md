# Helix Cheatsheet

> **Why?** Because I want to give Helix a try, so this is my cheatsheet!
> **Core logic:** select first, act after. `Escape` always goes back to normal (and auto-saves).
> **Letter shortcuts only work in NORMAL mode.** In INSERT, everything you type goes into the file.

---

## Getting directly into a projet

```
cd ~/project/path
hx .
```
or `hx ~/project/path`

## Modes

| Key | Mode | Where |
|---|---|---|
| `i` | INSERT — before cursor | NORMAL → INSERT |
| `a` | INSERT — after cursor | NORMAL → INSERT |
| `o` | INSERT — new line below | NORMAL → INSERT |
| `O` | INSERT — new line above | NORMAL → INSERT |
| `v` | SELECT character | NORMAL → SELECT |
| `V` | SELECT line | NORMAL → SELECT |
| `Escape` | Back to NORMAL (always) | INSERT / SELECT → NORMAL |

---

## Files & Buffers

| Key | Action | Mode |
|---|---|---|
| `Ctrl+S` | Save | any |
| `Ctrl+P` | File picker | any |
| `Ctrl+W` | Close buffer | any |
| `Ctrl+→` | Next buffer | any |
| `Ctrl+←` | Previous buffer | any |
| `Space f` | File picker | NORMAL |
| `Space b` | Buffer picker | NORMAL |
| `:o <file>` | Open file | NORMAL |
| `:q` | Quit | NORMAL |
| `:wq` | Save and quit | NORMAL |

---

## Navigation

| Key | Action | Mode |
|---|---|---|
| `h j k l` | Left / Down / Up / Right | NORMAL |
| `w` | Next word start | NORMAL |
| `b` | Previous word start | NORMAL |
| `e` | Next word end | NORMAL |
| `gg` | Go to top | NORMAL |
| `ge` | Go to bottom | NORMAL |
| `gd` | Go to definition | NORMAL |
| `gr` | Go to references | NORMAL |
| `gi` | Go to implementation | NORMAL |
| `gt` | Go to type definition | NORMAL |
| `Ctrl+D` | Scroll half page down | any |
| `Ctrl+U` | Scroll half page up | any |
| `%` | Jump to matching bracket | NORMAL |

---

## Selection & Editing

| Key | Action | Mode |
|---|---|---|
| `x` | Select current line | NORMAL |
| `d` | Delete selection | NORMAL |
| `c` | Change selection (delete + INSERT) | NORMAL |
| `y` | Yank (copy) | NORMAL |
| `p` | Paste after | NORMAL |
| `P` | Paste before | NORMAL |
| `u` | Undo | NORMAL |
| `U` | Redo | NORMAL |
| `Ctrl+/` | Toggle comment | any |
| `>` | Indent | NORMAL |
| `<` | Deindent | NORMAL |
| `~` | Swap case | NORMAL |

---

## Search & Replace

| Key | Action | Mode |
|---|---|---|
| `/` | Search forward | NORMAL |
| `?` | Search backward | NORMAL |
| `n` | Next match | NORMAL |
| `N` | Previous match | NORMAL |
| `*` | Search word under cursor | NORMAL |
| `:%s/old/new/g` | Replace all in file | NORMAL |

---

## LSP (Space menu)

| Key | Action | Mode |
|---|---|---|
| `Space a` | Code actions | NORMAL |
| `Space r` | Rename symbol | NORMAL |
| `Space s` | Symbol picker | NORMAL |
| `Space d` | Diagnostics picker | NORMAL |
| `Space h` | Hover (docs) | NORMAL |
| `Space w` | Save | NORMAL |
| `[d` | Previous diagnostic | NORMAL |
| `]d` | Next diagnostic | NORMAL |

---

## Multiple Cursors

| Key | Action | Mode |
|---|---|---|
| `C` | Add cursor on next match | NORMAL |
| `,` | Remove last cursor | NORMAL |
| `Alt+,` | Keep only primary cursor | NORMAL |
| `s` | Select regex within selection | NORMAL |
| `S` | Split selection by regex | NORMAL |

---

## Splits & Windows

| Key | Action | Mode |
|---|---|---|
| `Ctrl+W s` | Split horizontal | any |
| `Ctrl+W v` | Split vertical | any |
| `Ctrl+W h/j/k/l` | Move between splits | any |
| `Ctrl+W q` | Close split | any |

---

## Surround

| Key | Action | Mode |
|---|---|---|
| `ms<char>` | Add surround | NORMAL |
| `mr<old><new>` | Replace surround | NORMAL |
| `md<char>` | Delete surround | NORMAL |

> Example: select word → `ms"` wraps with quotes

---

## Quick Reference Card

```
NORMAL only:  h/j/k/l  w/b/e  gg/ge  d/c/y/p  u/U  >/<
              gd/gr/gi  Space+a/r/s/d/h  /  n/N  *
Any mode:     Ctrl+S  Ctrl+P  Ctrl+D/U  Ctrl+W+...
INSERT only:  just type — no letter shortcuts active
```
