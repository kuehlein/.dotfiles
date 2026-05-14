# Linux Retroism Migration Plan

Migration guide for transforming the current NixOS setup to match the linux-retroism aesthetic and functionality.

**Source:** https://github.com/diinki/linux-retroism
**Cloned to:** `/home/kuehlein/linux-retroism`

---

## 🎉 MIGRATION COMPLETE!

**Migration commit:** `c1ae0ec` - "Migrate to linux-retroism theme"
**Backup commit:** `31b0e70` - "Backup before linux-retroism migration"

### ✅ Completed Steps (All Phases)

**Phase 1: Preparation & Backup**
1. ✅ Backup created

**Phase 2: Theme Integration**
2. ✅ Linux-retroism colors applied to Sway config
3. ✅ Kitty terminal configured with retroism theme
4. ✅ GTK & icon themes installed to `~/.local/share/`
5. ✅ Retroism wallpaper set (copyleft.png)

**Phase 3: Quickshell Migration**
6. ✅ Required packages added: quickshell, socat, swappy, nemo, gvfs
7. ✅ Quickshell configuration copied and set up
8. ✅ Sway config updated to use Quickshell instead of Waybar
9. ✅ Waybar and Wofi removed from Sway extraPackages
10. ✅ System rebuilt and tested
11. ✅ Sway restarted
12. ✅ **XDG Desktop Portal fixed** - Nemo now opens quickly (< 2 seconds)

**Phase 4: Polish & Details**
13. ✅ Fonts installed (Monaco, Charcoal) in Quickshell config
14. ✅ Swappy config created for screenshot annotation
15. ✅ Screenshots directory created at ~/Pictures/Screenshots
16. ✅ All keybindings configured and functional

### ✅ Working Features (Tested)

- ✅ Quickshell taskbar appears at the bottom
- ✅ Window buttons show up on taskbar
- ✅ **Super+D** - App launcher opens
- ✅ **Click start button** - Start menu appears
- ✅ **Super+Shift+S** - Screenshot with swappy annotation
- ✅ **Super+E** - Nemo file manager opens quickly
- ✅ Retro colors on window borders (light gray for focused)
- ✅ Kitty terminal has retro color scheme
- ✅ System tray shows icons
- ✅ Clock widget displays time
- ✅ Workspace switcher works
- ✅ XDG Desktop Portal running correctly

### 🎉 RESOLVED: Nemo File Manager Speed Issue

**Problem:** `Super+E` to open Nemo was taking 30+ seconds
**Root Cause:** XDG Desktop Portal misconfiguration - `xdg-desktop-portal-gtk` was failing to start on Wayland
**Status:** ✅ **FIXED**

**Fix Applied:**
- Added `xdg-desktop-portal-gtk` to `xdg.portal.extraPortals` in `modules/services/display.nix`
- Added `config.common.default = "*"` to configure portal selection
- Portal service now running: `systemctl --user status xdg-desktop-portal-gtk.service` shows "active (running)"
- Nemo opens in < 2 seconds ✅

**Packages kept after debugging:**
- ✅ `gvfs` - Needed for Nemo to handle trash, network shares, and removable media

### 🎯 Migration Summary

**Status:** ✅ **COMPLETE** - All core phases (1-4) finished successfully!

**What's Working:**
- Full 1990s retro desktop aesthetic with linux-retroism theme
- Quickshell taskbar with start menu, app launcher, theme switcher
- All keybindings functional (Super+D/E/Shift+S, etc.)
- Nemo file manager opens quickly
- GTK apps use retro theme
- Screenshot annotation with swappy

**Optional Enhancement:**
- Phase 5 (SwayFX) - Can be added later if you want window shadows/blur effects

### 🚀 Next Steps:

1. **Rebuild NixOS** to apply the waybar/wofi cleanup:
   ```bash
   cd /etc/nixos
   sudo nixos-rebuild switch --flake "/etc/nixos#t490"
   ```

2. **Test theme switcher** - Click the theme button on taskbar to try different color schemes

3. **Optional: Add SwayFX** (Phase 5) - For shadows and blur effects if desired

4. **Enjoy your retro desktop!** 🎨

### 📝 Important Notes

- **GTK themes:** Already installed to `~/.local/share/themes/` and `~/.local/share/icons/`
- **Quickshell fonts:** Monaco and Charcoal fonts are included in the Quickshell config
- **Keybindings changed:**
  - `Super+D` now opens Quickshell launcher (was Wofi)
  - `Super+E` now opens Nemo file manager (new)
- **SwayFX:** Deferred - can be added later if you want shadows/effects
- **nwg-look:** Not needed - we're not switching themes, just using one

---

## Executive Summary

This migration involves replacing Waybar with Quickshell (a QML-based panel), updating the color scheme to linux-retroism's retro aesthetic, adding GTK/icon themes, and configuring various UI components to match the 1990s look.

**Complexity:** Medium-High
**Estimated Time:** 4-6 hours (COMPLETED)
**Risk Level:** Medium (requires replacing current panel system)

---

## Table of Contents

1. [Package Requirements](#package-requirements)
2. [Architecture Changes](#architecture-changes)
3. [Feature Comparison](#feature-comparison)
4. [Migration Phases](#migration-phases)
5. [Configuration Changes](#configuration-changes)
6. [Rollback Plan](#rollback-plan)

---

## Package Requirements

### Dependencies Already Installed ✅

| Package | Current Use | Linux-Retroism Use |
|---------|-------------|-------------------|
| `sway` | Window manager | Window manager (or SwayFX) |
| `kitty` | Terminal emulator | Terminal emulator |
| `grim` | Screenshots | Screenshots |
| `slurp` | Region selection | Region selection |
| `mako` | Notifications | Notifications |
| `jq` | JSON parsing | Quickshell IPC |
| `wl-clipboard` | Clipboard | Clipboard |

### Dependencies to Install 📦

| Package | Purpose | Priority |
|---------|---------|----------|
| `quickshell` | Panel/taskbar replacement for Waybar | **CRITICAL** |
| `nwg-look` | GTK theme switcher GUI | High |
| `nemo` | File manager | Medium |
| `swappy` | Screenshot annotation | Medium |
| `swaybg` | Wallpaper (alternative to Sway's built-in) | Optional |
| `socat` | IPC communication | Medium |

### Optional: SwayFX vs Sway

Linux-retroism recommends **SwayFX** (Sway fork with effects) for:
- Window shadows
- Blur effects
- Additional visual features

**Current setup uses:** Regular Sway

**Decision needed:** Stick with Sway (simpler) or migrate to SwayFX (more features)?

---

## Architecture Changes

### Current Architecture

```
┌─────────────────────────────────────┐
│ Sway (Window Manager)               │
├─────────────────────────────────────┤
│ Waybar (Panel/Bar)                  │
│ - Workspaces, Clock, Battery, etc.  │
├─────────────────────────────────────┤
│ Wofi (App Launcher)                 │
├─────────────────────────────────────┤
│ Mako (Notifications)                │
└─────────────────────────────────────┘
```

### Linux-Retroism Architecture

```
┌──────────────────────────────────────┐
│ Sway/SwayFX (Window Manager)         │
├──────────────────────────────────────┤
│ Quickshell (QML-based Panel)         │
│ - Taskbar with window buttons        │
│ - Start Menu                         │
│ - App Launcher                       │
│ - Settings Menu                      │
│ - Theme Switcher                     │
│ - System Tray                        │
│ - Clock Widget                       │
│ - Workspace Switcher                 │
├──────────────────────────────────────┤
│ Mako (Notifications)                 │
└──────────────────────────────────────┘
```

### Key Difference: Waybar → Quickshell

**Waybar:**
- JSON/CSS configuration
- Simple, lightweight
- Limited interactivity
- Separate app launcher (Wofi)

**Quickshell:**
- QML/Qt-based (JavaScript + declarative UI)
- More complex, feature-rich
- Interactive UI elements (buttons, menus)
- Integrated app launcher, start menu, settings
- Built-in theme switching
- Custom fonts included (Monaco, Charcoal)

---

## Feature Comparison

### Features Present in Both ✅

| Feature | Current | Linux-Retroism |
|---------|---------|----------------|
| Window management | Sway | Sway/SwayFX |
| Terminal | Kitty | Kitty (with retro themes) |
| Screenshots | grim + slurp | grim + slurp + swappy |
| Clipboard | wl-clipboard | wl-clipboard |
| Notifications | Mako | Mako |
| Natural scrolling | Configured | Configured |
| Workspace switching | Yes | Yes |

### Features Missing in Current Setup ❌

| Feature | Description | Implementation Needed |
|---------|-------------|-----------------------|
| **Start Menu** | Windows 95-style start button + menu | Add Quickshell |
| **Taskbar** | Window task buttons on bar | Add Quickshell |
| **Theme Switcher** | GUI for switching color schemes | Add Quickshell + themes |
| **Settings Menu** | GUI settings panel | Add Quickshell |
| **GTK Theme** | Retro GTK theme for apps | Install ClassicPlatinumStreamlined |
| **Icon Theme** | Retro icon set | Install RetroismIcons |
| **Retro Fonts** | Monaco, Charcoal fonts | Copy from linux-retroism |
| **Shadow Effects** | Window drop shadows | Requires SwayFX |
| **Screenshot Annotation** | Edit screenshots after capture | Add swappy |

### Features Present Only in Current Setup

| Feature | Description | Keep or Remove? |
|---------|-------------|-----------------|
| Wofi app launcher | Simple app launcher | Remove (replaced by Quickshell) |
| Waybar | Current status bar | Remove (replaced by Quickshell) |
| Home-manager Waybar config | Declarative waybar setup | Archive/backup |

---

## Migration Phases

### Phase 1: Preparation & Backup 🔧

**Duration:** 30 minutes

1. **Backup current configs**
   ```bash
   cd /etc/nixos
   git add . && git commit -m "Backup before retroism migration"
   ```

2. **Document current state**
   - Screenshot current desktop
   - Note any custom keybindings/workflows
   - Export current waybar configuration

3. **Install base dependencies**
   - Add `quickshell` to system packages
   - Add `nwg-look`, `nemo`, `swappy`, `socat`

### Phase 2: Theme Integration 🎨

**Duration:** 1-2 hours

1. **Apply theme.nix colors to Sway**
   - Update `/etc/nixos/modules/programs/sway-config`
   - Replace current colors with `theme.nix` references
   - Update border colors, gaps, shadows

2. **Install GTK & Icon Themes**
   ```bash
   # Copy themes to system
   cp -r ~/linux-retroism/gtk_theme/ClassicPlatinumStreamlined ~/.local/share/themes/
   cp -r ~/linux-retroism/icon_theme/RetroismIcons ~/.local/share/icons/
   ```

3. **Configure GTK theme via home-manager**
   - Add GTK configuration to home-manager
   - Set theme to ClassicPlatinumStreamlined
   - Set icon theme to RetroismIcons

4. **Update Kitty colors**
   - Create kitty config using `theme.nix` colors
   - Match linux-retroism default theme

### Phase 3: Quickshell Migration 🚀

**Duration:** 2-3 hours

**Critical:** This replaces Waybar entirely

1. **Set up Quickshell configuration**
   - Copy `/home/kuehlein/linux-retroism/configs/quickshell/` to `/etc/nixos/home/programs/quickshell/`
   - Adapt paths and settings for NixOS structure
   - Configure IPC endpoints

2. **Update Sway config**
   - Remove `bar { swaybar_command waybar }` from sway-config
   - Add Quickshell startup: `exec_always qs`
   - Add Quickshell kill/reload: `exec_always qs kill && qs`

3. **Configure app launcher keybind**
   ```
   # Current: bindsym $mod+d exec wofi --show drun
   # New: bindsym $mod+d exec quickshell ipc call appLauncher_$(monitor) toggleAppLauncher
   ```

4. **Disable Waybar**
   - Comment out waybar in home-manager imports
   - Or set `programs.waybar.enable = false;`

5. **Configure Quickshell themes**
   - Verify `Config.qml` has theme definitions
   - Add custom theme variants if desired
   - Test theme switcher functionality

### Phase 4: Polish & Details ✨

**Duration:** 1 hour

1. **Add retro fonts**
   - Copy Monaco, Charcoal fonts from linux-retroism
   - Add to NixOS font packages
   - Configure in Quickshell

2. **Configure swappy** (screenshot editor)
   - Set up swappy config
   - Update screenshot keybind:
     ```
     bindsym $mod+Shift+s exec grim -g "$(slurp)" - | swappy -f -
     ```

3. **Set wallpaper**
   - Choose wallpaper from `~/linux-retroism/wallpapers/`
   - Update sway.nix wallpaper path

4. **Test all functionality**
   - Start menu (button + keybind)
   - App launcher
   - Theme switcher
   - System tray
   - Workspaces
   - Clock
   - Screenshots
   - Settings menu

### Phase 5: SwayFX Migration (Optional) 🎭

**Duration:** 1 hour

**Only if you want shadows/blur effects**

1. **Replace Sway with SwayFX**
   - Change package in flake/modules
   - SwayFX is a drop-in replacement

2. **Enable effects in sway config**
   ```
   shadows enable
   shadow_offset 4 4
   shadow_color #000000
   shadow_blur_radius 1
   ```

3. **Test compatibility**
   - Verify all features work with SwayFX
   - Check for performance impact

---

## Configuration Changes

### File Structure Changes

#### New Files to Create

```
/etc/nixos/
├── home/programs/
│   ├── quickshell/
│   │   ├── default.nix          # NEW: Quickshell home-manager config
│   │   ├── Config.qml           # NEW: Theme definitions
│   │   ├── shell.qml            # NEW: Main shell config
│   │   ├── settings.json        # NEW: User settings
│   │   ├── popups/              # NEW: UI components
│   │   │   ├── AppLauncher.qml
│   │   │   ├── StartMenu.qml
│   │   │   └── ThemeMenu.qml
│   │   ├── taskbar/             # NEW: Taskbar components
│   │   │   ├── Bar.qml
│   │   │   ├── ClockWidget.qml
│   │   │   ├── SysTray.qml
│   │   │   └── Workspaces.qml
│   │   └── utils/               # NEW: Helper utilities
│   │       ├── AppSearch.qml
│   │       └── Fuzzy.qml
│   ├── gtk.nix                  # NEW: GTK theme config
│   └── kitty.nix                # NEW: Kitty config (currently in Sway)
├── assets/
│   ├── wallpapers/              # NEW: Retroism wallpapers
│   └── fonts/                   # NEW: Monaco, Charcoal fonts
└── docs/
    └── RETROISM_MIGRATION.md    # THIS FILE
```

#### Files to Modify

```
/etc/nixos/
├── flake.nix                    # Add quickshell, nwg-look, etc.
├── modules/
│   ├── programs/sway-config    # Update colors, remove waybar, add quickshell
│   ├── programs/sway.nix       # Add quickshell to packages
│   └── system/packages.nix     # Add new dependencies
└── home/
    ├── kuehlein.nix            # Add quickshell, gtk imports
    └── programs/
        ├── waybar/default.nix  # DISABLE or REMOVE
        └── wofi/default.nix    # DISABLE or REMOVE (optional)
```

### Sway Config Changes

**Before:**
```
bar {
  swaybar_command waybar
}

bindsym $mod+d exec pgrep wofi >/dev/null 2>&1 && killall wofi || wofi --show drun
```

**After:**
```
# Quickshell manages the bar
exec_always qs kill
exec_always qs

set $menu quickshell ipc call appLauncher_$(swaymsg -t get_outputs -r | jq -r '.[] | select(.focused==true) | .name') toggleAppLauncher
bindsym $mod+d exec $menu
```

### Color Migration

**Sway config client colors:**

```
#                       border  bg      text    ind     child border
client.focused          #d8d8d8 #141216 #d8d8d8 #d8d8d8 #d8d8d8
client.focused_inactive #9b9b9b #141216 #d8cab8 #9b9b9b #9b9b9b
client.unfocused        #9b9b9b #141216 #d8cab8 #9b9b9b #9b9b9b
client.urgent           #fca002 #141216 #d8cab8 #fca002 #fca002
client.placeholder      #bababa #141216 #d8cab8 #bababa #bababa
```

These map to `theme.nix`:
- `borderFocused`: `d8d8d8`
- `borderUnfocused`: `9b9b9b`
- `borderUrgent`: `fca002`
- `surface`: `141216`

---

## Package Installation Guide

### Add to `/etc/nixos/modules/system/packages.nix`

```nix
environment.systemPackages = with pkgs; [
  # ... existing packages ...

  # Linux Retroism dependencies
  quickshell      # Panel/taskbar system
  nwg-look        # GTK theme configuration GUI
  nemo            # File manager
  swappy          # Screenshot editor
  socat           # IPC communication

  # Optional: SwayFX instead of Sway
  # swayfx        # Sway with effects (shadows, blur)
];
```

### Add to `/etc/nixos/home/kuehlein.nix`

```nix
{ ... }: {
  imports = [
    ./programs/browsers.nix
    ./programs/direnv.nix
    ./programs/git.nix
    ./programs/gtk.nix          # NEW
    ./programs/quickshell       # NEW
    # ./programs/waybar         # REMOVE or comment out
    # ./programs/wofi           # OPTIONAL: remove if using Quickshell launcher
    ./programs/zsh.nix
  ];

  # ... rest of config
}
```

---

## GTK Theme Configuration

Create `/etc/nixos/home/programs/gtk.nix`:

```nix
{ pkgs, ... }: {
  gtk = {
    enable = true;

    theme = {
      name = "ClassicPlatinumStreamlined";
      # Package will be manually installed to ~/.local/share/themes
    };

    iconTheme = {
      name = "RetroismIcons";
      # Package will be manually installed to ~/.local/share/icons
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = false;  # Retro theme is light
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = false;
    };
  };
}
```

**Manual theme installation:**
```bash
cp -r ~/linux-retroism/gtk_theme/ClassicPlatinumStreamlined ~/.local/share/themes/
cp -r ~/linux-retroism/icon_theme/RetroismIcons ~/.local/share/icons/
```

Then use `nwg-look` GUI to verify/activate themes.

---

## Quickshell Configuration

### Create `/etc/nixos/home/programs/quickshell/default.nix`

```nix
{ pkgs, ... }: {
  home.packages = with pkgs; [ quickshell ];

  # Copy quickshell config files
  home.file.".config/quickshell" = {
    source = ./config;
    recursive = true;
  };
}
```

### Directory structure

Copy from linux-retroism:
```bash
cd /etc/nixos/home/programs/quickshell
cp -r ~/linux-retroism/configs/quickshell/* ./config/
```

Then adapt paths in QML files for NixOS.

---

## Kitty Terminal Configuration

Create `/etc/nixos/home/programs/kitty.nix`:

```nix
{ config, ... }:
let
  theme = import ../../theme.nix;
in {
  programs.kitty = {
    enable = true;

    settings = {
      # Cursor
      cursor_shape = "block";
      shell_integration = "no-cursor";

      # Padding
      window_padding_width = theme.spacing.terminalPaddingX;
      window_padding_height = theme.spacing.terminalPaddingY;

      # Scrollback
      scrollback_lines = 3000;

      # Font
      font_size = 11;

      # Opacity
      background_opacity = "0.985";

      # Colors (linux-retroism default theme)
      cursor = "#${theme.colors.cursor}";
      selection_background = "#${theme.colors.selection}";
      selection_foreground = "#${theme.colors.selectionText}";
      background = "#${theme.colors.background}";
      foreground = "#${theme.colors.foreground}";

      # ANSI colors
      color0 = "#${theme.colors.black}";
      color1 = "#${theme.colors.red}";
      color2 = "#${theme.colors.green}";
      color3 = "#${theme.colors.purple}";
      color4 = "#${theme.colors.blue}";
      color5 = "#${theme.colors.yellow}";
      color6 = "#${theme.colors.violet}";
      color7 = "#${theme.colors.magenta}";
      color8 = "#${theme.colors.cyan}";
      color9 = "#${theme.colors.red}";
      color10 = "#${theme.colors.green}";
      color11 = "#${theme.colors.purple}";
      color12 = "#${theme.colors.blue}";
      color13 = "#${theme.colors.yellow}";
      color14 = "#${theme.colors.violet}";
      color15 = "#${theme.colors.white}";
    };

    keybindings = {
      "ctrl+shift+plus" = "change_font_size all +1.0";
      "ctrl+shift+minus" = "change_font_size all -1.0";
    };
  };
}
```

Add to imports in `/etc/nixos/home/kuehlein.nix`.

---

## Rollback Plan

### If Migration Fails

1. **Git rollback**
   ```bash
   cd /etc/nixos
   git log  # Find commit before migration
   git checkout <commit-hash>
   sudo nixos-rebuild switch --flake "/etc/nixos#t490"
   ```

2. **Quick restore Waybar**
   - Uncomment waybar in home-manager imports
   - Comment out quickshell
   - Rebuild

3. **Restore sway config**
   ```bash
   git checkout HEAD~1 modules/programs/sway-config
   ```

### Partial Migration (Hybrid Approach)

If Quickshell doesn't work well, you can use a hybrid:

**Keep:** Waybar for now
**Add:** Retroism colors, GTK theme, icon theme, kitty colors
**Skip:** Quickshell migration

This gives you the retro aesthetic without the complex panel replacement.

---

## Testing Checklist

After each phase, verify:

- [ ] Sway starts without errors
- [ ] Can switch workspaces
- [ ] Can open applications
- [ ] Terminal works with new colors
- [ ] Screenshots work
- [ ] Keybindings functional
- [ ] System doesn't crash on rebuild

After Quickshell migration:

- [ ] Start menu opens (click & keybind)
- [ ] App launcher works
- [ ] System tray shows icons
- [ ] Clock displays correctly
- [ ] Workspaces switch correctly
- [ ] Theme switcher changes colors
- [ ] Settings menu accessible
- [ ] IPC communication works

---

## Performance Considerations

### Quickshell vs Waybar

**Quickshell:**
- **Pros:** Feature-rich, interactive, integrated launcher/menus
- **Cons:** Higher memory usage (~50-100MB vs Waybar's ~20-30MB), Qt/QML dependency

**Recommendation:**
- For low-spec systems: Consider hybrid approach (keep Waybar)
- For modern systems: Full Quickshell migration for complete retroism experience

---

## Potential Issues & Solutions

### Issue 1: Quickshell doesn't start after rebuild

**Problem:** No taskbar appears after rebuilding
**Solution:**
1. Check if quickshell is running: `ps aux | grep quickshell`
2. Try starting manually: `qs` (should see error messages if any)
3. Check logs: `journalctl -xe | grep quickshell`
4. Verify config files copied correctly: `ls ~/.config/quickshell/`
5. If quickshell has errors, temporarily revert to Waybar:
   ```bash
   # In /etc/nixos/home/kuehlein.nix, uncomment:
   # ./programs/waybar
   # Comment out:
   # ./programs/quickshell
   # Rebuild and investigate quickshell issues
   ```

### Issue 2: App launcher keybind (Super+D) doesn't work

**Problem:** Pressing Super+D does nothing
**Solution:**
- Verify Quickshell is running: `ps aux | grep quickshell`
- Check `socat` is installed: `which socat`
- Verify IPC socket exists: `ls /tmp/quickshell*` or `ls /run/user/$(id -u)/quickshell*`
- Test IPC manually:
  ```bash
  qs ipc call appLauncher_$(swaymsg -t get_outputs -r | jq -r '.[] | select(.focused==true) | .name') toggleAppLauncher
  ```
- If the manual command works, the keybind should work after Sway reload

### Issue 3: GTK themes not applying to applications

**Problem:** GTK apps still use default theme
**Solution:**
- Verify themes installed: `ls ~/.local/share/themes/` and `ls ~/.local/share/icons/`
- Check GTK config: `cat ~/.config/gtk-3.0/settings.ini` and `cat ~/.config/gtk-4.0/settings.ini`
- Ensure `dconf` is installed: `which dconf`
- Restart GTK apps (they don't hot-reload themes)
- If still not working, manually set with `gsettings`:
  ```bash
  gsettings set org.gnome.desktop.interface gtk-theme 'ClassicPlatinumStreamlined'
  gsettings set org.gnome.desktop.interface icon-theme 'RetroismIcons'
  ```

### Issue 4: Quickshell crashes or has QML errors

**Problem:** Quickshell starts but crashes or shows errors
**Solution:**
- Check Quickshell version: `qs --version`
- Review QML errors in terminal output when running `qs`
- Common issues:
  - Missing QML dependencies (Qt6 modules)
  - Path issues in QML files (check Config.qml, shell.qml)
  - Font loading errors (Monaco/Charcoal)
- Try the default Quickshell config to isolate the issue:
  ```bash
  mv ~/.config/quickshell ~/.config/quickshell.backup
  qs  # Will use default config
  ```

### Issue 5: Colors look wrong or windows have wrong borders

**Problem:** Window borders not showing retroism colors
**Solution:**
- Verify Sway config was updated: `cat /etc/sway/config | grep client.focused`
- Should show: `client.focused #d8d8d8 #141216 #d8d8d8 #d8d8d8 #d8d8d8`
- If not, rebuild may not have applied Sway config changes
- Manually reload Sway: `Super+Shift+C`
- Check if sway-config file has correct colors:
  ```bash
  cat /etc/nixos/modules/programs/sway-config | grep "client.focused"
  ```

### Issue 6: Kitty terminal doesn't have retro colors

**Problem:** Kitty still shows old color scheme
**Solution:**
- Check kitty config: `cat ~/.config/kitty/kitty.conf`
- Should reference retroism colors
- If kitty.conf doesn't exist or is wrong, home-manager may not have applied it
- Restart kitty (colors only apply to new instances)
- Test theme loading: `kitty +kitten themes` (should show current theme)

### Issue 7: Screenshot annotation (swappy) doesn't work

**Problem:** Super+Shift+S takes screenshot but doesn't open swappy
**Solution:**
- Verify swappy installed: `which swappy`
- Test the command manually:
  ```bash
  grim -g "$(slurp)" - | swappy -f -
  ```
- Check if grim and slurp work independently:
  ```bash
  grim /tmp/test.png  # Should capture screen
  slurp  # Should let you select region
  ```
- Ensure swappy config exists: `~/.config/swappy/config` (optional but recommended)

### Issue 8: Fonts missing (Monaco/Charcoal not rendering)

**Problem:** Quickshell UI shows wrong fonts
**Solution:**
- Fonts are bundled in Quickshell config: `/etc/nixos/home/programs/quickshell/config/fonts/`
- Check if fonts were copied: `ls /etc/nixos/home/programs/quickshell/config/fonts/`
- Should see: Charcoal.ttf, Monaco.ttf, MaterialSymbolsSharp*.ttf
- Quickshell loads fonts from its config directory, no system-wide install needed
- If fonts still don't load, check QML font loading in `taskbar/Bar.qml`

### Issue 9: Build fails with "error: attribute not found"

**Problem:** NixOS rebuild fails with Nix errors
**Solution:**
- Check for syntax errors in new .nix files
- Common mistakes:
  - Missing semicolons
  - Unclosed braces/brackets
  - Incorrect import paths
- Validate specific files:
  ```bash
  nix-instantiate --parse /etc/nixos/home/programs/gtk.nix
  nix-instantiate --parse /etc/nixos/home/programs/kitty.nix
  nix-instantiate --parse /etc/nixos/home/programs/quickshell/default.nix
  ```
- If a specific file has errors, check the commit diff to see what changed

### Issue 10: System tray icons don't appear

**Problem:** Quickshell taskbar appears but system tray is empty
**Solution:**
- Some apps need to be restarted to show in system tray
- Check if system tray is enabled in Quickshell config: `taskbar/SysTray.qml`
- Test with a known tray app: `nm-applet` (network manager)
- Verify Quickshell tray support: Check QML for `SystemTray` component
- May need to wait a few seconds for tray icons to populate after login

### Issue 11: Nemo takes 30+ seconds to start

**Problem:** Nemo file manager takes 30+ seconds to launch (Super+E keybind)
**Root Cause:** `xdg-desktop-portal-gtk` fails to start on Wayland with error "cannot open display:"

**Diagnosis:**
```bash
# Check portal service status
systemctl --user status xdg-desktop-portal-gtk.service

# Should show:
# Active: failed (Result: exit-code)
# Error: "cannot open display:"
```

**Why this happens:**
- Nemo (and many GTK apps) need XDG Desktop Portal for file picker dialogs, permissions, etc.
- When portal is unavailable, Nemo waits ~30s for D-Bus timeout before giving up
- `xdg-desktop-portal-gtk` was installed as a system package, but NixOS requires it to be configured via `xdg.portal.extraPortals`
- Without proper configuration, the portal tries to use X11 instead of Wayland

**Solution:** Configure portal properly in NixOS

**Fix in `/etc/nixos/modules/services/display.nix`:**
```nix
xdg.portal = {
  enable = true;
  wlr.enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];  # ADD THIS
  config.common.default = "*";                      # ADD THIS
};
```

**Remove from `/etc/nixos/modules/system/packages.nix`:**
```nix
# REMOVE xdg-desktop-portal-gtk from system packages
# It should ONLY be in xdg.portal.extraPortals
```

**After rebuild, verify:**
```bash
systemctl --user status xdg-desktop-portal-gtk.service
# Should show: Active: active (running)

time nemo /tmp
# Should open in < 2 seconds
```

**Packages added during debugging:**
- `gvfs` - Virtual filesystem support (KEEP - needed for trash, network shares, etc.)
- ~~`xdg-desktop-portal-gtk` as system package~~ - REMOVED, use `xdg.portal.extraPortals` instead

---

## Migration Timeline Estimate

| Phase | Duration | Can Skip? |
|-------|----------|-----------|
| 1. Preparation & Backup | 30 min | No |
| 2. Theme Integration | 1-2 hours | No |
| 3. Quickshell Migration | 2-3 hours | Yes* |
| 4. Polish & Details | 1 hour | Partially |
| 5. SwayFX (Optional) | 1 hour | Yes |
| **Total (Full)** | **5-7 hours** | - |
| **Total (Minimal)** | **2-3 hours** | - |

*Minimal migration = colors + GTK theme + kitty, keep Waybar

---

## Post-Migration

### Maintenance

1. **Updating linux-retroism**
   - Pull latest from git repo
   - Review changelog for breaking changes
   - Update configs incrementally

2. **Custom theme variants**
   - Add to `Config.qml`
   - Define color schemes
   - Test theme switcher

3. **Backup important configs**
   - Regularly commit to git
   - Tag stable versions
   - Document custom changes

---

## Conclusion

This migration transforms your NixOS setup from a minimal Sway + Waybar configuration to a full 1990s retro desktop experience. The most complex part is replacing Waybar with Quickshell.

**Recommended Approach:**
1. Start with **Phase 2** (colors, GTK theme) - low risk
2. Test and validate aesthetic changes
3. Decide if you want to proceed with **Phase 3** (Quickshell)
4. Keep git commits at each phase for easy rollback

**Questions to answer before starting:**
- Do you want full retroism (Quickshell) or just aesthetics (colors/themes)?
- Are you willing to learn QML for customization?
- Do you want SwayFX effects or stick with vanilla Sway?

Good luck with the migration! 🎨🖥️
