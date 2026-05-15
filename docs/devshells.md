# DevShells quick reference

This note is a practical reminder for using the project devShells before adopting `direnv`.

## Mental model

`devShells` are temporary development environments declared in the flake.

They do not install tools globally in the system profile. They make tools available only inside the shell started by `nix develop`, and only to programs launched from that shell.

```text
NixOS modules
  permanent system configuration

Home Manager
  permanent user configuration

devShells
  temporary project environments
```

## Shells

| Shell     | Purpose                  | Main tools                                             |
| --------- | ------------------------ | ------------------------------------------------------ |
| `default` | general Nix/repo work    | `git`, `nil`, `nixd`, `nixfmt`, `deadnix`, `nvd`       |
| `java`    | Java/Spring projects     | `jdk21`, `maven`                                       |
| `rust`    | Rust projects            | `rustc`, `cargo`, `rust-analyzer`, `rustfmt`, `clippy` |
| `c`       | C projects               | `gcc`, `gnumake`, `pkg-config`, `gdb`                  |
| `flutter` | Flutter/Android projects | `flutter`, Android SDK, `android-tools`, `jdk21`       |
*(flutter is temporary)*

## Aliases and functions

These commands assume the system flake lives at:

```bash
~/nixos-config
```

| Command       | What it does                       | I use when                                   |
| ------------- | ---------------------------------- | -------------------------------------------- |
| `nd`          | Runs `nix develop` manually        | I want to type the target myself             |
| `ndd`         | Enters `~/nixos-config#default`    | I want the default dev shell                 |
| `ndj`         | Enters `~/nixos-config#java`       | I am working in a Java/Spring project        |
| `ndr`         | Enters `~/nixos-config#rust`       | I am working in a Rust project               |
| `ndc`         | Enters `~/nixos-config#c`          | I am working in a C project                  |
| `ndf`         | Enters `~/nixos-config#flutter`    | I am working in Flutter from the terminal    |
| `nds <shell>` | Enters a named shell               | I want a generic helper, e.g. `nds rust`     |
| `ndz <shell>` | Opens Zed inside a named shell     | I want Zed to inherit a specific environment |
| `zjava`       | Opens Zed inside the Java shell    | I want Zed to see Java/Maven                 |
| `zrust`       | Opens Zed inside the Rust shell    | I want Zed to see Rust tooling               |
| `zc`          | Opens Zed inside the C shell       | I want Zed to see C tooling                  |
| `zflutter`    | Opens Zed inside the Flutter shell | I want Zed to see Flutter/Android/JDK        |

## Terminal workflow

To run commands directly in the terminal.

```bash
cd ~/Projects/my-rust-project
ndr
cargo build
cargo test
exit
```

```bash
cd ~/Projects/onefreela
ndj
mvn test
exit
```

```bash
cd ~/Projects/mobile-app
ndf
flutter doctor
flutter run
exit
```

## Zed workflow

Zed only inherits the devShell if it is launched from inside that environment.

Option A: enter the shell first, then open Zed.

```bash
cd ~/Projects/my-rust-project
ndr
zed .
```

Option B: use the Zed helper directly.

```bash
cd ~/Projects/my-rust-project
zrust
```

For Flutter (temporarily):

```bash
cd ~/Projects/mobile-app
zflutter
```

## `ndf` vs `zflutter`

Use one or the other depending on the task.

```text
ndf
  enters the Flutter devShell in the current terminal

zflutter
  opens Zed inside the Flutter devShell
```

Do not run both unless you specifically want to. If you already ran `ndf`, just use:

```bash
zed .
```

If you did not enter the shell yet, use:

```bash
zflutter
```

The same logic applies to the other shells:

```text
ndr    -> terminal Rust environment
zrust  -> Zed opened with Rust environment

ndj    -> terminal Java environment
zjava  -> Zed opened with Java environment

ndc    -> terminal C environment
zc     -> Zed opened with C environment
```

## What stays outside devShells

These remain NixOS modules because they are system services or global compatibility layers.

| Module               | Why it stays outside devShell                                    |
| -------------------- | ---------------------------------------------------------------- |
| `virtualisation.nix` | Docker needs daemon/socket/systemd/cgroups integration           |
| `redis.nix`          | Redis is a local system service with port/bind/systemd lifecycle |
| `databases.nix`      | MySQL/PostgreSQL services belong to the system layer             |
| `nix-ld.nix`         | Compatibility layer for external non-Nix binaries                |

A devShell can contain client tools, but long-running services should stay as NixOS modules.

Examples:

```text
PostgreSQL server
  system module

psql client
  can be in a devShell

Redis server
  system module

redis-cli
  can be in a devShell
```

## Direct commands without aliases

Aliases are only convenience wrappers. The raw commands are:

```bash
nix develop ~/nixos-config#default
nix develop ~/nixos-config#java
nix develop ~/nixos-config#rust
nix develop ~/nixos-config#c
nix develop ~/nixos-config#flutter
```

To run a command directly inside a shell without staying inside it:

```bash
nix develop ~/nixos-config#rust -c cargo test
nix develop ~/nixos-config#java -c mvn test
nix develop ~/nixos-config#flutter -c flutter doctor
```

To open Zed directly:

```bash
nix develop ~/nixos-config#rust -c zed .
nix develop ~/nixos-config#java -c zed .
nix develop ~/nixos-config#flutter -c zed .
```