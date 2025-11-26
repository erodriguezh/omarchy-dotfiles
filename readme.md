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

On first `chezmoi apply` after init, `.chezmoi.toml.tmpl` will prompt you:

- `machine_type` — use `"mac"` on the MacBook, `"surface-go-3"` or `"other"` elsewhere.
- `is_laptop`
- `gpu`

The answers are written to `~/.config/chezmoi/chezmoi.toml` and then used by all templates.

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
