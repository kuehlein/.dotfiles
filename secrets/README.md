# Secrets Management with SOPS

This directory contains encrypted secrets managed by [sops-nix](https://github.com/Mic92/sops-nix).

## Structure

```
secrets/
├── README.md           # This file
├── secrets.yaml        # Encrypted secrets file
└── keys/              # Public keys for encryption
    └── hosts/         # Host machine keys
        └── t490.txt   # t490 machine public key
```

## How It Works

1. **Secrets are encrypted** using age encryption with the host's SSH key
2. **Encrypted files are safe** to commit to git - they're useless without the private key
3. **NixOS decrypts automatically** at system activation time using `/etc/ssh/ssh_host_ed25519_key`
4. **Each machine can have** its own key, and secrets can be shared across multiple machines

## Usage

### Editing Secrets

To edit the encrypted secrets file, you need sudo to access the system's SSH host key:

```bash
# This will decrypt, open in $EDITOR, then re-encrypt on save
sudo nix-shell -p sops ssh-to-age --run 'SOPS_AGE_KEY_FILE=<(ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key) sops secrets/secrets.yaml'
```

### Adding New Secrets

1. Edit the secrets file as shown above
2. Add your key-value pairs in YAML format:
   ```yaml
   my-api-key: "super-secret-value"
   my-password: "another-secret"
   ```
3. Save and close - sops will automatically re-encrypt

### Using Secrets in NixOS Configuration

Example in a NixOS module:

```nix
{ config, ... }:
{
  # Define the secret
  sops.secrets."example-api-key" = {
    sopsFile = ../secrets/secrets.yaml;
    owner = "kuehlein";
    group = "users";
    mode = "0400";  # Read-only for owner
  };

  # Use the secret (path will be /run/secrets/example-api-key)
  environment.systemPackages = [ ... ];

  # Example: use in a service
  systemd.services.my-service = {
    script = ''
      export API_KEY=$(cat ${config.sops.secrets."example-api-key".path})
      # ... use the secret
    '';
  };
}
```

### Using Secrets in Home-Manager

For user-specific secrets:

```nix
{ config, ... }:
{
  sops.secrets."my-personal-token" = {
    sopsFile = ../secrets/secrets.yaml;
    path = "${config.home.homeDirectory}/.config/my-app/token";
  };
}
```

## Adding a New Machine

When you get a new machine:

1. Get its age public key:
   ```bash
   sudo cat /etc/ssh/ssh_host_ed25519_key.pub | \
     nix-shell -p ssh-to-age --run ssh-to-age
   ```

2. Save the public key:
   ```bash
   echo "age1..." > secrets/keys/hosts/<hostname>.txt
   ```

3. Update `.sops.yaml` at the root:
   ```yaml
   keys:
     - &new_machine age1...

   creation_rules:
     - path_regex: secrets/secrets\.yaml$
       key_groups:
         - age:
             - *t490
             - *new_machine  # Add here
   ```

4. Re-encrypt all secrets with the new key:
   ```bash
   sudo nix-shell -p sops --run "sops updatekeys secrets/secrets.yaml"
   ```

## Security Notes

- ✅ **Safe to commit**: Encrypted secrets can be pushed to public repos
- ✅ **Host keys**: Private keys are in `/etc/ssh/` and never leave the machine
- ✅ **Automatic decryption**: NixOS handles decryption at activation
- ✅ **Scoped access**: Each secret can have specific permissions (owner, group, mode)

- ⚠️ **Keep private keys safe**: Never commit private keys to git
- ⚠️ **Rotate secrets**: If a private key is compromised, rotate all secrets
- ⚠️ **Backup carefully**: Include public keys in backups, but be careful with private keys

## Common Secrets to Store

```yaml
# API tokens
github-token: "ghp_..."
openai-api-key: "sk-..."

# Passwords
wifi-password: "..."
vpn-password: "..."

# SSH/GPG keys (as multiline strings)
ssh-private-key: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  ...
  -----END OPENSSH PRIVATE KEY-----

# Application configs
database-url: "postgresql://user:pass@host/db"
```

## Troubleshooting

### "no key could decrypt the data"

Make sure the private key exists and matches the public key:
```bash
sudo ls -la /etc/ssh/ssh_host_ed25519_key
```

### "cannot find age key"

sops-nix looks for the host key at `/etc/ssh/ssh_host_ed25519_key`. Make sure it exists.

### "failed to get the data key"

Your public key might not be in the `.sops.yaml` file, or the secret wasn't encrypted with your key. Run `sops updatekeys`.

## References

- [sops-nix Documentation](https://github.com/Mic92/sops-nix)
- [SOPS Documentation](https://github.com/getsops/sops)
- [age Encryption](https://github.com/FiloSottile/age)
