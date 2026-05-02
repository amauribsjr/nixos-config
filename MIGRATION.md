# Migration to btrfs + zram

> Plan: btrfs root with subvolumes, zram-only swap (no disk swap), zstd:1 compression.
> Optimized for the Inspiron 3501's DRAM-less SSD (KIOXIA BG4) and 7.5 GB RAM.

---

## What changed from previous plan

| Before | After | Why |
|---|---|---|
| 3 partitions (ESP/swap/btrfs) | 2 partitions (ESP/btrfs) | DRAM-less SSD, 8% wear — minimize disk writes |
| Dedicated 8 GB swap partition | No disk swap | zram only — never touches disk |
| zswap kernel params | Removed | Without disk swap, zswap is irrelevant |
| `compress=zstd:3` | `compress=zstd:1` | Pentium Gold 7505 is the bottleneck, not the NVMe |
| `space_cache=v2`, `ssd` | Removed | Both are auto-default on kernel 6.x |
| `services.fstrim.enable = true` | `false` | `discard=async` handles TRIM continuously |
| `zramSwap.memoryPercent = 100` | `50` | Leaves more RAM for active working set during compiles |

## What stayed

- 4 subvolumes: `@`, `@home`, `@nix`, `@log` (with `neededForBoot = true` on `/var/log`)
- systemd-boot
- `linuxPackages_latest`
- `vm.swappiness = 180`, `vm.page-cluster = 0` (correct for zram)
- All non-storage config: TLP, Bluetooth auto-connect, niri, etc.

---

## 1. Branch strategy

Discard old `btrfs` branch, start fresh:

```sh
cd ~/nixos-config
git branch -D btrfs              # if exists locally
git push origin --delete btrfs   # if exists remotely
git checkout -b btrfs-zram
```

`main` stays untouched. Merge only after install validates.

---

## 2. Files to change

Only **3 files** in `system/hardware/`:

- `hardware.nix` — replace entirely (btrfs subvolumes, no swapDevices)
- `boot.nix` — replace entirely (no zswap params, sysctl preserved)
- `power.nix` — replace entirely (zramSwap 50%, fstrim disabled, rest identical)

Plus `INSTALL.md` at the repo root.

The other 27 `.nix` files in the repo are **untouched**.

---

## 3. Pre-install

1. **Backup `/home/koppi`** to external drive:
   ```sh
   rsync -avh --progress /home/koppi/ /run/media/koppi/<EXTERNAL>/koppi-backup/
   ```
   Especially: `~/.ssh/`, `~/Pictures/Wallpapers/wallpaper.png`, in-progress projects, local Helix configs.

2. **Push branch** to GitHub:
   ```sh
   git add system/hardware/ INSTALL.md MIGRATION.md
   git commit -m "btrfs subvolumes + zram-only swap"
   git push -u origin btrfs-zram
   ```

3. **Note repo URL** (no SSH key on installer ISO):
   ```
   https://github.com/amauribsjr/nixos-config
   ```

---

## 4. Post-install validation

```sh
# Subvolumes mounted
findmnt -t btrfs
# Expected: 4 lines, all on /dev/nvme0n1p2, subvol=@/@home/@nix/@log

# Swap is zram only — no disk swap
swapon --show
# Expected: only /dev/zram0

# Compression is zstd:1
sudo btrfs property get / compression
# Expected: compression=zstd:1 (or unset, inheriting mount option)

# discard=async active
mount | grep btrfs | head -1
# Expected output contains "discard=async"

# zram active and sized correctly
zramctl
# Expected: ~3.7G size for 7.5G RAM
```

If any check fails, rollback via systemd-boot menu and reinstall.

---

## 5. Risks

| Risk | Mitigation |
|---|---|
| Wrong disk in `parted` | INSTALL.md forces `lsblk` verification |
| Subvolume name mismatch between INSTALL and hardware.nix | Both written together, names match literally |
| Boot fails (btrfs not in initrd) | `boot.supportedFilesystems = [ "btrfs" ]` forces it |
| OOM during heavy compile | zram 50% + ~10GB effective; if hit, add `services.earlyoom.enable = true` later |
| Data loss | Explicit backup step 3.1, double-check before `mkfs` |
| niri-flake compiles from source | Cache `niri.cachix.org` is auto-enabled by `nixosModules.niri` |

---

## 6. Cleanup after stable use

```sh
git checkout main
git merge btrfs-zram
git push
git branch -D btrfs-zram
git push origin --delete btrfs-zram
```