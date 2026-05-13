# Age Public Keys

This directory contains age public keys for machines and users that can decrypt secrets.

## Hosts

- `hosts/t490.txt` - Lenovo ThinkPad T490 (primary work machine)

## Adding a New Host

1. Get the SSH host key:
   ```bash
   sudo cat /etc/ssh/ssh_host_ed25519_key.pub
   ```

2. Convert to age format:
   ```bash
   nix-shell -p ssh-to-age --run "ssh-to-age < /etc/ssh/ssh_host_ed25519_key.pub"
   ```

3. Save to `hosts/<hostname>.txt`

4. Update `.sops.yaml` to include the new key

## Adding a Personal Key

If you want to decrypt secrets from your personal machine (not the NixOS host):

1. Generate an age key:
   ```bash
   nix-shell -p age --run "age-keygen -o ~/.config/sops/age/keys.txt"
   ```

2. Extract the public key and save it to `users/<username>.txt`

3. Update `.sops.yaml` to include the new key
