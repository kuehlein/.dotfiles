# NixOS Configuration

*Personal NixOS configuration for t490 (Lenovo ThinkPad T490)*

A modular NixOS configuration using flakes and home-manager with Sway.

---

## Quick Start

### Rebuild System

```bash
sudo nixos-rebuild switch --flake "/etc/nixos#t490"
```

### Update System

```bash
nix flake update
sudo nixos-rebuild switch --flake "/etc/nixos#t490"
```

---

## Common Tasks

### Bluetooth

**Connect to paired device:**
```bash
headphones        # Connect to Sony WH-1000XM3
headphones-off    # Disconnect headphones
```

**First-time pairing:**
```bash
bluetoothctl
> power on
> agent on
> default-agent
> scan on
# Wait for device to appear, then:
> pair XX:XX:XX:XX:XX:XX
> trust XX:XX:XX:XX:XX:XX
> connect XX:XX:XX:XX:XX:XX
> exit
```

**List paired devices:**
```bash
bluetoothctl devices
```

### WiFi

```bash
# List available networks
nmcli device wifi list

# Connect to network
nmcli device wifi connect <SSID>        # Without password
nmcli device wifi connect <SSID> --ask  # With password
```

### Volume Control

```bash
pactl set-sink-volume @DEFAULT_SINK@ <x>%
```

---

## Configuration Structure

```
/etc/nixos/
├── flake.nix                  # Main flake entry point
├── configuration.nix          # Base system configuration
├── hardware-configuration.nix
│
├── modules/
│   ├── system/                # System-level configurations
│   ├── services/              # Service configurations
│   ├── programs/              # Program configurations (sway)
│   └── packages/              # Custom packages (brave, witr)
│
├── home/                      # Home-manager configurations
│   ├── kuehlein.nix
│   └── programs/
│
├── docs/                      # Documentation
│   ├── SETUP.md               # Initial setup guide
│   ├── SECRETS.md             # Secrets management guide
│   ├── REFERENCE.md           # Nix commands reference
│   └── TROUBLESHOOTING.md     # Common issues
│
├── secrets/                   # Encrypted secrets (sops-nix)
│   ├── secrets.yaml           # Encrypted secrets file
│   └── keys/                  # Public keys for encryption
│
└── assets/                    # Wallpapers and resources
```

---

## Documentation

- **[Setup Guide](docs/SETUP.md)** - Initial setup for SSH, Git, and GitHub
- **[Secrets Management](docs/SECRETS.md)** - Managing secrets with sops-nix
- **[Reference](docs/REFERENCE.md)** - Nix and NixOS commands
- **[Troubleshooting](docs/TROUBLESHOOTING.md)** - Common issues and solutions

---

## TODO

### Configuration
- Multiple host configurations
- Review and potentially remove optional systemd dependencies:
  - Consider replacing `systemd-resolved` with traditional DNS
  - Evaluate `systemd-timesyncd` vs `chrony`/`ntpd`
  - Review other optional systemd components for minimization

### Theme
- Windows95 theme - [Chicago95 repo](https://github.com/grassmunk/Chicago95/tree/master)
  - Cascading menu - [cascading menu repo](https://github.com/kin-fuyuki/deskdate)

### Hardware
- Disable Intel ME (QM370)

---

## System Information

- **Host:** t490 (Lenovo ThinkPad T490)
- **Window Manager:** Sway (Wayland)
- **Terminal:** Kitty
- **Shell:** Zsh
- **Editor:** Neovim
- **Browser:** Brave
