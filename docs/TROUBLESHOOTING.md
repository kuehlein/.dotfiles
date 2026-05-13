# Troubleshooting Guide

Common issues and their solutions.

---

## Secrets Management

See [SECRETS.md](SECRETS.md) for troubleshooting sops-nix issues.

---

## Build Failures

### Flake evaluation errors

```bash
nix flake check  # Check for errors without building
nix flake show   # Show flake outputs
```

---

## Git Issues

### Permission Denied (publickey)

SSH key may not be properly decrypted. Check:

```bash
ls -la ~/.ssh/id_ed25519_github
# Should show mode 600 and owned by you
```

If missing, the secrets aren't being decrypted. See [SECRETS.md](SECRETS.md).

### Test GitHub connection

```bash
ssh -vT git@github.com
```

Should output: "Hi kuehlein! You've successfully authenticated..."

---

## System Issues

### Rebuild hangs or fails

Try a dry build first:
```bash
sudo nixos-rebuild dry-build --flake "/etc/nixos#t490"
```

### Network issues after rebuild

Check NetworkManager:
```bash
systemctl status NetworkManager
nmcli device status
```
