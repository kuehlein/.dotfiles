# Initial Setup Guide

Quick reference for setting up a fresh NixOS installation with this configuration.

---

## Fresh Install

1. **Clone this repo:**
   ```bash
   git clone https://github.com/kuehlein/nixos-config /etc/nixos
   cd /etc/nixos
   ```

2. **Initial secrets setup:**

   SSH keys are managed by sops-nix. On first build, the system will fail to decrypt secrets. This is expected.

   After first build, add your SSH key to the encrypted secrets:
   ```bash
   sudo nix-shell -p sops --run "sops secrets/secrets.yaml"
   # Add your GitHub SSH private key
   ```

   See [SECRETS.md](SECRETS.md) for details.

3. **Rebuild:**
   ```bash
   sudo nixos-rebuild switch --flake "/etc/nixos#t490"
   ```

---

## Configuration Changes

After modifying the configuration:

```bash
cd /etc/nixos
sudo nixos-rebuild switch --flake "/etc/nixos#t490"
```

---

## Notes

- SSH keys are managed via sops-nix (see `docs/SECRETS.md`)
- Git config is declarative (see `home/programs/git.nix`)
- User environment is managed by home-manager
- All configuration is version controlled
