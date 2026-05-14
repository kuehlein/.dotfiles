# NixOS Configuration Maintenance Notes

This document tracks maintenance considerations for third-party packages and forks used in this configuration.

---

## SwayFX (Window Manager Fork)

**Package:** `swayfx`
**Upstream:** https://github.com/WillPower3309/swayfx
**Status as of May 2026:** Active maintenance

### Why We Use It
SwayFX is a fork of Sway that adds visual effects (shadows, rounded corners, blur) to match the linux-retroism retro aesthetic. It's a drop-in replacement that uses the exact same configuration file as Sway.

### Maintenance Risk Assessment
- **Risk Level:** Low-Medium
- **Primary Maintainer:** WillPower3309
- **Community:** 2,244 stars, 104 forks (as of May 2026)
- **Recent Activity:** Last commit April 2026, actively maintained
- **Package Availability:** Maintained in nixpkgs

### Exit Strategy
If SwayFX becomes unmaintained or problematic:

1. **Switch back to Sway** (one-line change in flake.nix):
   ```nix
   # In modules/programs/sway.nix or similar
   # Change: programs.sway.package = pkgs.swayfx;
   # To:     programs.sway.package = pkgs.sway;
   ```

2. **Remove SwayFX-specific config** from `modules/programs/sway-config`:
   ```bash
   # Remove these lines:
   shadows enable
   shadow_offset 4 4
   shadow_color #000000
   shadow_blur_radius 1
   # (and any other SwayFX-only options)
   ```

3. **Rebuild:**
   ```bash
   sudo nixos-rebuild switch --flake "/etc/nixos#t490"
   ```

4. **Restart Sway:** Log out and back in, or press `Super+Shift+C`

### What to Monitor
- Check GitHub activity quarterly: https://github.com/WillPower3309/swayfx/commits/main
- Watch for nixpkgs issues: `nix search nixpkgs swayfx` should still work
- If Sway makes breaking changes upstream, SwayFX may lag behind

### Alternative Options
If SwayFX is abandoned:
- **Hyprland** - Another Wayland compositor with effects (heavier, different config)
- **Regular Sway** - No effects, but rock-solid and upstream-maintained
- **Wayfire** - Compiz-like effects, different paradigm

---

## Future Maintenance Items

### Quickshell
- **Status:** Active (check https://github.com/outfoxxed/quickshell)
- **Risk:** Low (QML-based, stable API)
- **Fallback:** Can revert to Waybar if needed (config preserved in git history)

### Custom Themes
- GTK theme: `ClassicPlatinumStreamlined` (local install in `~/.local/share/themes/`)
- Icon theme: `RetroismIcons` (local install in `~/.local/share/icons/`)
- These are static files and don't require upstream maintenance

---

## Maintenance Schedule

### Quarterly (every 3 months)
- [ ] Check SwayFX GitHub for recent commits
- [ ] Verify nixpkgs still includes swayfx: `nix search nixpkgs swayfx`
- [ ] Review open issues for critical bugs

### After Major NixOS Updates
- [ ] Test SwayFX still builds and runs
- [ ] Check for Sway version compatibility issues
- [ ] Verify all effects still work (shadows, corners, etc.)

### Annual Review
- [ ] Reassess SwayFX maintenance status
- [ ] Consider alternatives if maintenance has stalled
- [ ] Update this document with current status

---

## Last Updated
**Date:** May 14, 2026
**Reviewer:** kuehlein
**Status:** All packages active and maintained
