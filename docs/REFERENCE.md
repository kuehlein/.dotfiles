# Nix Reference

Quick reference for common Nix and NixOS commands.

---

## Flake Commands

```bash
nix flake metadata              # Show flake metadata
nix flake update                # Update all flake inputs
nix flake show                  # Check outputs for flake
```

---

## Common Nix Commands

```bash
nix run                         # Run a packaged binary (outputs.packages."SYSTEM".default)
nix build                       # Build a package (outputs.packages."SYSTEM".default)
nix develop                     # Activate dev shell (outputs.devShells."SYSTEM".default)
nix repl                        # Start Nix REPL
nix derivation show /nix/store/<hash>-file_name.drv
```

---

## Output Mappings

- `nix run/build` → `outputs.packages."SYSTEM".default`
- `nix develop` → `outputs.devShells."SYSTEM".default`
- `nixos-rebuild` → `outputs.nixosConfigurations."HOSTNAME"`
- `home-manager` → `outputs.homeConfigurations."USERNAME"`

---

## System Management

### Rebuild System

```bash
sudo nixos-rebuild switch --flake "/etc/nixos#t490"
```

### Update Neovim Config

```bash
nix flake lock --update-input neovim-config
sudo nixos-rebuild switch --flake "/etc/nixos#t490"
```

### Garbage Collection

```bash
sudo nix-collect-garbage --delete-older-than <x>d  # x = number of days
```

---

## Useful Shell Commands

### Copy current branch name to clipboard

```bash
git branch --show-current | tr -d '\n' | wl-copy
```
