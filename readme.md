# omarchy-dotfiles

Dotfiles for Omarchy on a Surface Go 3 and a MacBook 11,4.

This repo follows the **Omarchy** patterns:

- Never manage Omarchy-owned configs directly (Hyprland/Waybar main files).
- Use includes and overlays from `~/.config`.
- Use small, self-contained, idempotent `run_*` scripts for installs and system tweaks.

---

## Machine type configuration

This repo uses a `machine_type` variable to enable Mac-specific scripts (keyboard, power, Waybar overrides, etc.).

### Recommended: interactive config

On first install with this repo

```bash
# Initialize chezmoi with your dotfiles repo
chezmoi init https://github.com/erodriguez/omarchy-dotfiles.git

# OR if you already have the repo cloned:
chezmoi init --source=/path/to/omarchy-dotfiles
```

`.chezmoi.toml.tmpl` will prompt you:

- `machine_type` — use `"mac"` on the MacBook, `"surface-go-3"` or `"other"` elsewhere.
- `is_laptop`
- `gpu`

**Choose wisely:**

- **MacBook 11,4**: `machine_type = "mac"`, `is_laptop = true`, `gpu = "intel"`
- **Surface Go 3**: `machine_type = "surface-go-3"`, `is_laptop = true`, `gpu = "intel"`
- **Other**: Adjust as needed

Afterwards go ahead and preview changes (recommended)

```bash
# See what would be applied without making changes
chezmoi diff
```

If everything looks good apply dotfiles

```bash
# Apply all configurations and run setup scripts
chezmoi apply
```

### What happens during apply

1. **Files are created:**
   - `~/.config/hypr/overrides.conf` (+ `mac-overrides.conf` on Mac)
   - `~/.config/waybar/overrides.json`
   - `~/.config/ghostty/overrides.conf`
   - `~/.bashrc_extensions`

2. **Config injections run:**
   - Hyprland sources added to `hyprland.conf`
   - Ghostty config-file directive added to `config`
   - Bashrc source directive added to `.bashrc`

3. **Packages installed** (via yay/paru):
   - Bitwarden Desktop
   - Mullvad VPN
   - VS Code (via Omarchy helper)
   - TLP + TLPUI (Mac only)

4. **Mac-specific tweaks** (if `machine_type = "mac"`):
   - Keyboard fnmode configured (media keys default)
   - German Mac keyboard layout set
   - TLP installed (replaces power-profiles-daemon)
   - Waybar config patched with battery controls

5. **All done!** Log out and back in (or reboot) to ensure everything loads.

### Manual override / recovery

If you ever need to recreate or edit the config manually:

```bash
chezmoi edit-config
```

or directly edit:

```toml
# ~/.config/chezmoi/chezmoi.toml
[data]
    machine_type = "mac"      # or "surface-go-3", "other"
    is_laptop    = true
    gpu          = "intel"
```

If the config is broken or missing:

```bash
rm -f ~/.config/chezmoi/chezmoi.toml
chezmoi apply   # will re-run the prompts from .chezmoi.toml.tmpl
```

## Recovery

If Mac-specific behavior stops working, ensure:

1. `~/.config/chezmoi/chezmoi.toml` has:

    ```toml
    [data]
        machine_type = "mac"
    ```

2. Re-run:

    ```bash
    chezmoi apply
    ```

to re-run scripts that add Hyprland includes and patch Waybar.
