# My NixOS Configuration

This repository contains my declarative NixOS configuration. It's public, so no secrets (like SSH keys) are stored here.

## Bootstrapping on a New System

1. **Install NixOS Minimally**:
   - Boot from the NixOS ISO.
   - Partition and mount your disks (e.g., `/mnt` for root).
   - Generate a basic config: `nixos-generate-config --root /mnt`
   - Edit `/mnt/etc/nixos/configuration.nix` to include essentials (e.g., boot loader, networking).

2. **Clone This Repo (Initially via HTTPS)**:
   - Install Git: Add `environment.systemPackages = [ pkgs.git ];` to `configuration.nix`.
   - Rebuild: `nixos-install`
   - After reboot, as root: `cd /etc/nixos && git clone https://github.com/yourusername/your-nixos-config-repo.git .`
   - (The dot `.` clones into the current directory.)

3. **Set Up SSH Keys for GitHub**:
   - Generate a new SSH key pair (or copy from backup/old system):
ssh-keygen -t ed25519 -C "your.email@example.com" -f /root/.ssh/id_ed25519
   - Set a passphrase for security.
   - Set permissions: `chmod 700 /root/.ssh && chmod 600 /root/.ssh/id_ed25519 && chmod 644 /root/.ssh/id_ed25519.pub`
   - If copying from backup: `cp /path/to/backup/id_ed25519* /root/.ssh/` and set ownership/permissions as above.
   - Add the public key to GitHub:
   - `cat /root/.ssh/id_ed25519.pub`
   - Paste into GitHub > Settings > SSH and GPG keys > New SSH key.
   - Add key to agent (if passphrase): `ssh-add /root/.ssh/id_ed25519`

4. **Switch to SSH Remote**:
   - `git remote set-url origin git@github.com:yourusername/your-nixos-config-repo.git`

5. **Rebuild the System**:
   - `nixos-rebuild switch`
   - This applies the full config, including SSH/Git settings for root.

6. **Backup Your Keys**:
   - Copy `/root/.ssh/id_ed25519*` to an encrypted external drive or password manager.
   - Never commit them to this repo!

Now you can edit and commit changes as root: `git add . && git commit -m "Update" && git push`.





TODO:
 - a lot
 - disable intel ME (QM370)

 Note:
 - Whenever updating `neovim-config` repo, run `nix flake lock --update-input neovim-config`

 - `sudo nix-collect-garbage --delete-older-than xd` where `x` is # of days -- to delete older builds




 ---

 pending next build:
  - neovim config integration
  - nix-prefetch-scripts


---

`nix flake metadata` =>

`nix flake update`

`nix run` => runs a packaged binary.
|___ outputs.packages."SYSTEM".default

`nix build` => builds a package
|___ outputs.packages."SYSTEM".default

`nix develop` => activates a dev shell
|___ outputs.devShells."SYSTEM".default

`nixos-rebuild` => builds a nixos system
|___ outputs.nixosConfigurations."HOSTNAME"

`home-manager` => builds a home configuration
|___ outputs.homeConfigurations."USERNAME"

`nix repl` => repl for nix

`nix derivation show /nix/store/<hash>-file_name.drv`

`nix flake show` => check outputs for flake




`git branch --show-current | tr -d '\n\ | wl-copy`
