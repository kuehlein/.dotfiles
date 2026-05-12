# NixOS Configuration Cleanup Triage

**Last Updated:** 2026-05-12
**Machine:** t490 (Lenovo ThinkPad T490)
**Primary Use:** Work and development
**Status:** Pre-cleanup analysis

---

## Executive Summary

This document provides a comprehensive analysis of the current NixOS configuration and outlines all necessary cleanup tasks to achieve a professional, maintainable, and well-structured system configuration. The configuration is functional but contains several architectural issues, inconsistencies, and leftover experimental code from testing different window managers.

**Severity Levels:**
- **CRITICAL:** Must fix - causes bugs or security issues
- **HIGH:** Should fix soon - violates best practices or causes maintainability issues
- **MEDIUM:** Should address - improves organization and clarity
- **LOW:** Nice to have - cosmetic or minor improvements

---

## 1. CRITICAL ISSUES

### 1.1 Git Repository State [CRITICAL]
**File:** `.git/index`
**Issue:** Deleted file `setups/hyprland/default.nix` is staged but not committed
**Impact:** Git tree is dirty; unclear what the intended state is
**Action:**
```bash
git add setups/hyprland/default.nix  # Commit the deletion
git commit -m "Remove hyprland setup (using sway instead)"
```

### 1.2 Networking Configuration Conflict [CRITICAL]
**Files:** `configuration.nix:12`, `hardware-configuration.nix:35`
**Issue:** `networking.useDHCP` is set to `false` in configuration.nix but `lib.mkDefault true` in hardware-configuration.nix
**Impact:** Unclear which takes precedence; could cause network issues
**Root Cause:** configuration.nix sets `useDHCP = false` but doesn't configure alternative networking
**Action:**
- If using NetworkManager (which you are), remove the `networking.useDHCP = false;` line from configuration.nix
- Let hardware-configuration.nix handle DHCP settings with its lib.mkDefault
- Or explicitly set per-interface DHCP if needed

### 1.3 Security: Plain Text Default Password [CRITICAL]
**File:** `modules/common.nix:120`
**Issue:** `initialPassword = "changeme";` is in plain text
**Impact:** Security risk if not changed immediately
**Action:**
- Remove `initialPassword` entirely if password has been changed
- Or use `hashedPassword` instead (generate with `mkpasswd -m sha-512`)
- Add comment documenting that this is first-boot only

### 1.4 Hardcoded User Paths [CRITICAL]
**File:** `modules/git.nix:12`
**Issue:** SSH config hardcoded to `/home/kuehlein/.ssh/id_ed25519_github`
**Impact:** Won't work for kyle user; breaks if kuehlein is removed
**Action:**
- Move SSH configuration to per-user home-manager config
- Or parameterize the username if system-wide SSH config is truly needed
- Consider if system-wide git config makes sense vs per-user config

### 1.5 Misplaced Home-Manager Configuration [CRITICAL]
**File:** `hosts/t490/default.nix`
**Issue:** File contains `wayland.windowManager.sway.config.input` which is home-manager config, not NixOS module
**Impact:** This file is not actually imported anywhere and has no effect!
**Action:**
- Move touchpad configuration to appropriate home-manager user config
- Remove the `hosts/t490/default.nix` file entirely
- Or restructure to be a proper host-specific NixOS module if needed

### 1.6 XDG Portal Forcefully Disabled [CRITICAL]
**File:** `modules/common.nix:127`
**Issue:** `xdg.portal.enable = lib.mkForce false;` with TODO comment
**Impact:** Breaks file pickers, screen sharing, and other desktop integration features
**Action:**
- Enable XDG portal: `xdg.portal.enable = true;`
- Add xdg-desktop-portal-wlr for Wayland: `xdg.portal.wlroots.enable = true;`
- Remove the TODO and test that apps work correctly

---

## 2. HIGH PRIORITY ISSUES

### 2.1 Redundant User Accounts [HIGH]
**Files:** `modules/common.nix:100-124`, `home/kuehlein.nix`, `home/kyle.nix`
**Issue:** Two nearly identical users (kuehlein and kyle) with identical home configs
**Analysis:**
- Both users have the same `home.stateVersion`, imports, and services
- Both have identical gnome-keyring setup
- Only TODOs differentiate them (work vs browsing)
- This violates the stated preference for simplicity

**Decision Required:**
For a work machine, typical options are:
1. **Single user** (most common for personal work machine) - just kuehlein
2. **Main user + guest** (if you occasionally have visitors) - kuehlein + guest
3. **Multiple personal users** (if you truly need separate profiles) - keep both but differentiate them

**Recommendation:** Single user approach
- Remove kyle user entirely
- Use a single well-configured kuehlein account
- If different "modes" are needed, use different projects/workspaces, not users
- Guest accounts on work machines are uncommon; most people use a single user

**Action:**
- Decide on user structure
- Remove kyle user from `modules/common.nix`
- Delete `home/kyle.nix`
- Remove kyle from `flake.nix:38`
- Update git.nix to not be kuehlein-specific

### 2.2 Inconsistent Module Organization [HIGH]
**Files:** `modules/`, `setups/`
**Issue:** Unclear distinction between `modules/` and `setups/`
**Current State:**
- `modules/` contains: common.nix, git.nix, witr.nix
- `setups/` contains: common.nix, sway/

**Problem:** `setups/common.nix` looks like it should be in `modules/` (Brave extensions)

**Best Practice Structure:**
```
modules/
  ├── system/        # System-level configurations
  │   ├── boot.nix
  │   ├── network.nix
  │   └── security.nix
  ├── services/      # Service configurations
  │   ├── git.nix
  │   └── mullvad.nix
  ├── desktop/       # Desktop environment configs
  │   └── sway.nix
  └── packages/      # Custom package derivations
      └── witr.nix
```

**Action:**
- Rename `setups/` to `desktop/` or merge into `modules/desktop/`
- Move `setups/common.nix` content into modules (or into home-manager if user-specific)
- Remove the now-empty `setups/` directory
- Update imports in flake.nix

### 2.3 Flake Description Outdated [HIGH]
**File:** `flake.nix:2`
**Issue:** Description says "multiple setups (Sway, Hyprland & DWM)" but only Sway exists
**Action:**
```nix
description = "NixOS configuration with Sway for t490";
```

### 2.4 Commented-Out Code Everywhere [HIGH]
**Files:** Multiple
**Issue:** Dead/commented code throughout:
- `flake.nix:27-28` - hyprland and dwm references
- `setups/sway/default.nix:6` - wofi import
- `setups/sway/default.nix:12` - config.keybinds
- `setups/sway/config:19-20` - polkit and gnome-keyring execs
- `setups/sway/config:41` - file explorer setting
- `modules/common.nix:14` - systemd-boot TODO

**Action:**
- Remove all commented-out imports/code
- Delete the hyprland/dwm references from flake
- Clean up sway config comments
- Either enable wofi or remove the directory
- Make decision on systemd-boot vs grub and remove TODO

### 2.5 Incorrect Zsh Configuration [HIGH]
**File:** `home/common.nix:49`
**Issue:** Using `initContent` instead of `initExtra`
**Impact:** This is not a valid home-manager option and might not work
**Action:**
```nix
programs.zsh.initExtra = ''
  # content here
'';
```

### 2.6 Brave Browser Preferences Conflict [HIGH]
**File:** `home/common.nix:7-17`
**Issue:** Writing directly to Brave's Preferences file will be overwritten by Brave
**Impact:** Settings won't persist
**Action:**
- Remove direct Preferences file writing
- Use policies (in setups/common.nix) or accept manual configuration
- Document in README if manual setup is needed

---

## 3. MEDIUM PRIORITY ISSUES

### 3.1 TODO Comments [MEDIUM]
**Issue:** Multiple TODO comments throughout codebase

**List of TODOs:**
1. `home/kuehlein.nix:1` - "This config should be oriented more towards super-user stuff"
2. `home/kyle.nix:1` - "The config for this user should be oriented towards regular browsing/use"
3. `modules/git.nix:2` - "swap out /home/kuehlein/... below"
4. `setups/common.nix:1` - "should this be in modules/common.nix?"
5. `modules/common.nix:14` - "consider not using systemd... (grub)?"
6. `modules/common.nix:101` - "refine user configuration"
7. `modules/common.nix:126` - "not sure about this..."

**Action:**
- Address or remove each TODO
- Document decisions in code comments if needed

### 3.2 Inconsistent Code Formatting [MEDIUM]
**File:** `setups/common.nix`
**Issue:** Inconsistent indentation (tabs vs spaces)
**Lines:** 23-24, 27-28, 32-33, 35-36 use tabs when rest uses spaces
**Action:**
- Standardize to 2-space indentation throughout
- Consider using `nixpkgs-fmt` or `alejandra` for consistent formatting

### 3.3 System vs User Package Placement [MEDIUM]
**File:** `modules/common.nix:18-42`
**Issue:** Some packages might be better placed in home-manager
**Examples:**
- Developer tools (sqlite, claude-code, neovim) → user packages
- Apps (inkscape, libreoffice, vlc) → user packages
- System utilities (inxi, lshw, dmidecode) → system packages

**Action:**
- Review each package and decide system vs user placement
- Move user-specific packages to home-manager
- Keep only system-level packages in modules/common.nix

### 3.4 Sway Packages in Wrong Place [MEDIUM]
**File:** `setups/sway/default.nix:24-30`
**Issue:** Development packages (gcc, nodejs, python3) in sway.extraPackages
**Impact:** These packages are tied to Sway for no reason
**Action:**
- Move gcc, nodejs, python3 to modules/common.nix or home-manager
- Keep only Sway-specific desktop packages in extraPackages

### 3.5 Unused Assets [MEDIUM]
**Directory:** `assets/`
**Issue:** 10 wallpaper images, but only sun.jpg is used
**Action:**
- Keep sun.jpg (currently used)
- Consider removing unused wallpapers or document them
- Or create a wallpaper rotation system

### 3.6 README Organization [MEDIUM]
**File:** `README.md`
**Issue:** README contains:
- Personal TODO notes mixed with documentation
- Verbose SSH setup instructions (good but could be in separate doc)
- Random Nix command reference
- Future planning notes

**Action:**
- Separate into:
  - `README.md` - Overview, quick start, rebuild commands
  - `docs/SETUP.md` - Detailed SSH/Git setup guide
  - `docs/REFERENCE.md` - Nix command reference
  - Remove or archive completed TODOs
  - Move "pending next build" notes to issues/project board

---

## 4. LOW PRIORITY ISSUES

### 4.1 Attribution in Sway Config [LOW]
**File:** `setups/sway/config:1-5`
**Issue:** Config header references "diinki" and "Linux Ricing Guide"
**Action:**
- Update header with your own attribution
- Or remove header if not needed
- Keep license info if using their base config

### 4.2 License Headers [LOW]
**File:** Root `LICENSE`
**Issue:** MIT license file exists but no headers in .nix files
**Action:**
- Add SPDX license identifiers to files if desired
- Or just keep LICENSE file (sufficient for most cases)

### 4.3 Empty Config File [LOW]
**File:** `setups/sway/config.keybinds`
**Issue:** File exists but is commented out; might be empty
**Action:**
- Remove if empty
- Or document its intended purpose

### 4.4 Wofi Directory Status [LOW]
**Directory:** `setups/sway/wofi/`
**Issue:** Wofi import is commented out; unclear if directory is used
**Action:**
- Either enable wofi or remove the directory
- Document decision

### 4.5 Duplicate Hardware Configuration [LOW]
**File:** `configuration.nix:4,7,8`
**Issue:** Some hardware settings duplicate hardware-configuration.nix
**Examples:**
- `boot.kernelModules = [ "i915" ];` - might be redundant
- `hardware.cpu.intel.updateMicrocode` - duplicates hardware-configuration.nix:40

**Action:**
- Review which settings are needed in both places
- Use lib.mkDefault in configuration.nix if overriding hardware-configuration.nix

---

## 5. ARCHITECTURAL IMPROVEMENTS

### 5.1 Host-Specific Configuration [MEDIUM]
**Current:** Everything is in flake.nix and modules/
**Issue:** Hard to scale to multiple machines
**Recommendation:**
```
hosts/
  └── t490/
      ├── default.nix         # Host-specific NixOS config
      ├── hardware.nix        # Rename from hardware-configuration.nix
      └── home.nix            # Host-specific home-manager overrides
```

Then import host config in flake.nix:
```nix
modules = [
  ./hosts/t490
  ./modules/common.nix
  # ...
];
```

### 5.2 Per-User Home Manager Files [MEDIUM]
**Current:** Users defined in flake.nix
**Recommendation:** Create `users/` directory structure:
```
users/
  └── kuehlein/
      ├── default.nix      # Main user config
      ├── programs/        # Program-specific configs
      │   ├── git.nix
      │   ├── zsh.nix
      │   └── sway.nix
      └── packages.nix     # User package list
```

### 5.3 Secrets Management [MEDIUM]
**Current:** No secrets management
**Future Need:** SSH keys, API tokens, etc.
**Recommendation:**
- Consider `agenix` or `sops-nix` for secrets
- Document secrets not in repo (SSH keys, etc.)

---

## 6. CLEANUP CHECKLIST

### Phase 1: Critical Fixes (Do First)
- [ ] Commit or revert hyprland deletion
- [ ] Fix networking.useDHCP conflict
- [ ] Remove/hash initialPassword
- [ ] Enable xdg.portal properly
- [ ] Fix hosts/t490/default.nix misplacement
- [ ] Decide on single vs multi-user approach

### Phase 2: High Priority (Do Soon)
- [ ] Remove kyle user (if deciding on single-user)
- [ ] Reorganize modules/ and setups/ directories
- [ ] Update flake description
- [ ] Remove all commented-out code
- [ ] Fix zsh initContent → initExtra
- [ ] Remove Brave Preferences direct write

### Phase 3: Medium Priority (Before Adding Features)
- [ ] Address all TODO comments
- [ ] Fix indentation consistency
- [ ] Reorganize system vs user packages
- [ ] Move development packages out of sway config
- [ ] Clean up README organization
- [ ] Review and remove unused assets

### Phase 4: Low Priority (Nice to Have)
- [ ] Update Sway config attribution
- [ ] Add license headers if desired
- [ ] Remove or enable wofi
- [ ] Clean up empty/unused files
- [ ] Review duplicate hardware settings

### Phase 5: Architectural (Optional but Recommended)
- [ ] Implement proper host structure
- [ ] Reorganize user home-manager configs
- [ ] Set up secrets management
- [ ] Add documentation structure

---

## 7. RECOMMENDED FILE STRUCTURE (After Cleanup)

```
/etc/nixos/
├── flake.nix                 # Main flake entry point
├── flake.lock
├── README.md                 # Overview and quick start
├── LICENSE
│
├── hosts/
│   └── t490/
│       ├── default.nix       # Host-specific NixOS config
│       ├── hardware.nix      # Hardware configuration
│       └── README.md         # Host-specific notes
│
├── modules/
│   ├── system/
│   │   ├── boot.nix
│   │   ├── networking.nix
│   │   └── security.nix
│   ├── services/
│   │   ├── git.nix
│   │   └── mullvad.nix
│   ├── desktop/
│   │   └── sway/
│   │       ├── default.nix
│   │       ├── config
│   │       └── waybar.nix
│   └── packages/
│       └── witr.nix
│
├── users/
│   └── kuehlein/
│       ├── default.nix
│       ├── programs/
│       │   ├── zsh.nix
│       │   ├── git.nix
│       │   └── browsers.nix
│       └── packages.nix
│
├── docs/
│   ├── SETUP.md             # Initial setup guide
│   ├── REFERENCE.md         # Nix commands reference
│   └── TROUBLESHOOTING.md   # Common issues
│
└── assets/
    └── wallpapers/
        └── sun.jpg
```

---

## 8. QUESTIONS TO ANSWER

Before proceeding with cleanup, please decide:

1. **User Setup:**
   - [ ] Single user (kuehlein only) - RECOMMENDED for work machine
   - [ ] Main user + guest account
   - [ ] Keep both kyle and kuehlein (need to differentiate them)

2. **Boot Loader:**
   - [ ] Keep systemd-boot (current)
   - [ ] Switch to GRUB

3. **Window Manager:**
   - [ ] Sway only (current state)
   - [ ] Keep option for multiple WMs

4. **Wofi:**
   - [ ] Enable and configure wofi
   - [ ] Remove wofi directory

5. **Configuration Style:**
   - [ ] Keep simple flat structure
   - [ ] Reorganize into recommended structure above

---

## 9. ESTIMATED EFFORT

- **Critical fixes:** 30-45 minutes
- **High priority:** 1-2 hours
- **Medium priority:** 2-3 hours
- **Low priority:** 1 hour
- **Architectural improvements:** 3-4 hours

**Total: 7-10 hours for complete cleanup**

---

## 10. NEXT STEPS

1. Review this triage document
2. Answer the questions in Section 8
3. Decide which phases to tackle
4. Create backup: `sudo cp -r /etc/nixos /etc/nixos.backup`
5. Start with Phase 1 (Critical Fixes)
6. Test rebuild after each phase
7. Commit changes incrementally

---

## Notes

- This is a work machine focused on simplicity and productivity
- All cleanup maintains current functionality
- No new features are added in cleanup phase
- Configuration is currently functional; cleanup improves maintainability
- Consider creating a separate branch for major restructuring

**Document Version:** 1.0
**Created by:** Claude Code
**Date:** 2026-05-12
