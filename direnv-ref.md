# direnv Cheatsheet

> **Why?** Because I want one `cd` to set up everything a project needs — toolchain, env vars, secrets — and forget the rest.
> **Core logic:** drop a `.envrc` in a folder, `direnv allow` it, and the env loads on `cd` in / unloads on `cd` out.
> **First load is slow, rest is instant.** The first `direnv allow` on a flake-based project runs `nix develop` underneath. Cached afterwards.

---

## Getting started in a project

```
cd ~/project/path
echo "use flake ~/nixos-config#rust" > .envrc
direnv allow
```

Confirm it loaded:
```
which cargo   # → /nix/store/...
```

---

## .envrc Templates

| Need | One-liner |
|---|---|
| Rust devshell from nixos-config | `echo "use flake ~/nixos-config#rust" > .envrc` |
| Java devshell from nixos-config | `echo "use flake ~/nixos-config#java" > .envrc` |
| C devshell from nixos-config | `echo "use flake ~/nixos-config#c" > .envrc` |
| Project's own flake.nix | `echo "use flake" > .envrc` |
| Just env vars | edit `.envrc` manually (see syntax below) |

Always run `direnv allow` after creating or editing `.envrc`.

---

## .envrc Syntax

| Line | What it does |
|---|---|
| `use flake` | Load devshell from `flake.nix` in current folder |
| `use flake <path>#<name>` | Load named devshell from external flake |
| `export VAR="value"` | Set env var |
| `export VAR="$(command)"` | Dynamic env var |
| `PATH_add ./bin` | Prepend folder to PATH |
| `source_env <path>` | Inherit another `.envrc` |
| `dotenv .env` | Load a standard `.env` file |

---

## Combining devshell + env vars

```
use flake ~/nixos-config#rust
export DATABASE_URL="postgresql://localhost/myproject"
export RUST_LOG="debug"
```

`direnv allow`. Tools come from the devshell, vars are scoped to the folder.

---

## Daily Commands

| Command | Action |
|---|---|
| `direnv allow` | Authorize current folder's `.envrc` (re-run after every edit) |
| `direnv deny` | Pause the env without deleting `.envrc` |
| `direnv reload` | Force reload now |
| `direnv status` | Show current state |
| `direnv edit` | Open `.envrc`, auto-allow on save |
| `direnv prune` | Clean up stale authorizations |

---

## Errors & Fixes

| Error / Symptom | Cause | Fix |
|---|---|---|
| `.envrc is blocked` | First time, or you just edited it | `direnv allow` |
| `flake .#X not found` | Wrong devshell name | Check `~/nixos-config/devshells.nix` |
| Tool not in PATH after allow | Hook not active in shell | `eval "$(direnv hook zsh)"` or open new terminal |
| Edited flake, env didn't update | Cache stale | `direnv reload` |
| Zed/Helix LSP broken in project | Editor opened before direnv loaded | `cd project` first, then open editor |
| `direnv: error in .envrc` | Syntax error in `.envrc` | Read line number, fix |
| `.direnv/` cache acting weird | Corrupted cache | `rm -rf .direnv && direnv allow` |

---

## Workflow with editors

direnv loads when the **shell** enters the folder. Editors don't trigger it — they inherit env from the shell that launched them.

Always: `cd <project>` first, then launch the editor. The shell aliases in `home/shell.nix` already do this for Zed:
- `rzed` / `jzed` / `czed` — open Zed inside a devshell

For Helix:
```
cd ~/project
hx .
```
Helix picks up the direnv env automatically.

---

## When NOT to use direnv

- One-shot scripts → `nix run` or `nix shell` directly
- Folders rarely visited → not worth the `.envrc`
- Anything that fits in a zsh alias → just alias it

direnv earns its keep when you return to the same folder repeatedly.

---

## Security note

`.envrc` is a shell script — `direnv allow` is your "I read this, I trust it" stamp. Always `cat .envrc` before allowing one from a cloned third-party repo.

Global gitignore already excludes `.envrc` and `.direnv/` — accidental commits are blocked.

---

## Quick Reference Card

```
Setup:    echo "use flake [path]#[shell]" > .envrc && direnv allow
Verify:   which <tool>     → should hit /nix/store/
Edited?:  direnv allow     (every single time)
Cached:   first load slow, rest instant
Editor:   cd in shell first, then open Zed/Helix
```
