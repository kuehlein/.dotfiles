# Secrets Management

This NixOS configuration uses [sops-nix](https://github.com/Mic92/sops-nix) for managing secrets like API keys, passwords, and credentials.

## Quick Start

### View/Edit Secrets

**Important:** Secrets are encrypted with the system's SSH host key, which only root can read.

```bash
# Edit encrypted secrets (will open in $EDITOR)
sudo nix-shell -p sops ssh-to-age --run 'SOPS_AGE_KEY_FILE=<(ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key) sops secrets/secrets.yaml'
```

### Add a New Secret

1. Open the secrets file (with sudo):
   ```bash
   sudo nix-shell -p sops ssh-to-age --run 'SOPS_AGE_KEY_FILE=<(ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key) sops secrets/secrets.yaml'
   ```

2. Add your secret in YAML format:
   ```yaml
   my-new-secret: "secret-value-here"
   ```

3. Save and close - sops automatically re-encrypts

### Use a Secret in NixOS

Edit `/etc/nixos/modules/system/secrets.nix`:

```nix
sops.secrets."my-new-secret" = {
  owner = "kuehlein";
  group = "users";
  mode = "0400";  # Read-only for owner
};
```

The secret will be available at: `/run/secrets/my-new-secret`

### Use in a Service

```nix
systemd.services.my-service = {
  script = ''
    export SECRET=$(cat /run/secrets/my-new-secret)
    # Use $SECRET here
  '';
};
```

## Multi-Machine Setup

### Adding a New Machine

1. **Extract the public key:**
   ```bash
   # On the new machine
   sudo cat /etc/ssh/ssh_host_ed25519_key.pub | \
     nix-shell -p ssh-to-age --run ssh-to-age
   ```

2. **Save it to the repo:**
   ```bash
   # On the main machine
   echo "age1xyz..." > secrets/keys/hosts/new-machine.txt
   git add secrets/keys/hosts/new-machine.txt
   ```

3. **Update `.sops.yaml`:**
   ```yaml
   keys:
     - &t490 age1j5stf7fgf2gfwptzn43tzma3cp7chzhuz025f98efefh4nzzuvjqgvz293
     - &new_machine age1xyz...  # Add this

   creation_rules:
     - path_regex: secrets/secrets\.yaml$
       key_groups:
         - age:
             - *t490
             - *new_machine  # Add this
   ```

4. **Re-encrypt secrets with new key:**
   ```bash
   nix-shell -p sops --run "sops updatekeys secrets/secrets.yaml"
   git add secrets/secrets.yaml .sops.yaml
   git commit -m "Add new-machine to secrets access"
   ```

Both machines can now decrypt the secrets

## Security Best Practices

### ✅ Do This

- **Commit encrypted secrets**
- **Rotate secrets** if a machine is compromised
- **Use specific permissions** - `mode = "0400"` for read-only
- **Set proper ownership** - assign secrets to the user that needs them
- **Keep private keys safe** - they never leave the machine
- **Use machine-specific secrets** when appropriate

### ❌ Don't Do This

- **Never commit private keys** (`/etc/ssh/ssh_host_ed25519_key`)
- **Don't share private keys** between machines
- **Don't use `0777` permissions** on secrets
- **Don't store secrets in plain text** anywhere in the repo
- **Don't skip validation** - enable `validateSopsFiles = true` once you have real secrets

## Current Secrets

This configuration currently has the following secrets encrypted and managed:

### SSH Keys (Migrated 2026-05-13)

- **GitHub SSH Key** (`ssh.github.private` / `ssh.github.public`)
  - Private key restored to: `/home/kuehlein/.ssh/id_ed25519_github`
  - Public key restored to: `/home/kuehlein/.ssh/id_ed25519_github.pub`
  - Used by: `home/programs/git.nix` for GitHub authentication
  - See: `modules/system/secrets.nix` for configuration

### API Tokens

Add API tokens to the secrets file:

```bash
sudo nix-shell -p sops ssh-to-age --run 'SOPS_AGE_KEY_FILE=<(ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key) sops secrets/secrets.yaml'
```

Example tokens:
- `github-token` - Personal access token
- `openai-api-key` - OpenAI API key
- Add any other service tokens

## Resources

- [sops-nix GitHub](https://github.com/Mic92/sops-nix)
- [SOPS Documentation](https://github.com/getsops/sops)
- [Age Encryption](https://github.com/FiloSottile/age)
- [NixOS Wiki: Secrets](https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes)
