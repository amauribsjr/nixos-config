# Migration to btrfs + zswap

> Complete plan. No unnecessary rewrites. Isolated branch. Current system stays functional.

---

## 1. Branch strategy

You already have an old `btrfs` branch in the repo. Recommend discarding it and starting clean:

```sh
cd ~/nixos-config
git branch -D btrfs              # if it still exists locally
git push origin --delete btrfs   # if it still exists remotely (optional)
git checkout -b btrfs-zswap
```

Keeps `main` untouched. The migration only gets merged **after** install is validated.

---

## 2. Files changed

Only **3 files** change, plus INSTALL.md. None rewritten from scratch — only the relevant blocks.

### 2.1 `system/hardware/hardware.nix` (replace entirely)

See `hardware.nix` in this directory.

### 2.2 `system/hardware/boot.nix` (replace entirely)

See `boot.nix`.

### 2.3 `system/hardware/power.nix` (only remove the zramSwap block)

At the top of the file, **delete** this block:

```nix
zramSwap = {
  enable        = true;
  algorithm     = "zstd";
  memoryPercent = 100;
  priority      = 100;
};
```

The rest of the file stays **identical**. Don't touch anything else.

### 2.4 `INSTALL.md` (replace entirely)

See `INSTALL.md`.

---

## 3. Pre-install

Before booting the USB:

1. **Back up `/home/koppi`** to an external drive:
   ```sh
   rsync -avh --progress /home/koppi/ /run/media/koppi/<EXTERNAL_DRIVE>/koppi-backup/
   ```
   Especially `~/.ssh/`, `~/Pictures/Wallpapers/`, in-progress projects, Helix configs if you've edited them post-install.

2. **Push the `btrfs-zswap` branch** to GitHub:
   ```sh
   git push -u origin btrfs-zswap
   ```

3. **Note the HTTPS repo URL** (the installer ISO won't have your SSH key yet):
   ```
   https://github.com/amauribsjr/nixos-config
   ```

---

## 4. Post-install validation

After first boot, run:

```sh
# Confirm subvolumes are mounted correctly
findmnt -t btrfs

# Confirm zswap active
cat /sys/module/zswap/parameters/enabled    # expected: Y
cat /sys/module/zswap/parameters/compressor # expected: zstd

# Confirm swap active
swapon --show

# Confirm btrfs compression
sudo btrfs property get / compression       # expected: zstd:3 (or inherited)
sudo compsize -x /                          # optional, requires pkgs.compsize
```

If something is wrong:

```sh
sudo nixos-rebuild switch --rollback
```

And go back to the previous boot via the systemd-boot menu.

---

## 5. Post-validation cleanup

After confirming everything works for **a few days** of normal use:

```sh
git checkout main
git merge btrfs-zswap
git push
git branch -D btrfs-zswap
git push origin --delete btrfs-zswap
```

---

## 6. Risks and mitigations

| Risk | Mitigation |
|---|---|
| Wrong disk in `parted` | INSTALL.md forces verification with `lsblk` before each destructive operation |
| Subvolume name mismatch between INSTALL and hardware.nix | Both files written together — `@`, `@home`, `@nix`, `@log` — match literally |
| zswap not loading | Declarative `boot.kernelParams`. Validation in step 4 detects failure |
| Boot fails (btrfs not in initrd) | `boot.supportedFilesystems = [ "btrfs" ]` in hardware.nix forces inclusion |
| Data loss | Explicit backup in step 3.1, double-check before `mkfs` |
| niri-flake breaks | No change in `flake.lock` — same current version |