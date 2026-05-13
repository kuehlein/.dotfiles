{ config, ... }:

{
  # Configure sops-nix for secrets management
  sops = {
    # Default sops file for secrets
    defaultSopsFile = ../../secrets/secrets.yaml;

    # Validate that sops can decrypt at build time
    validateSopsFiles = false; # Set to true after testing

    # Age key derived from SSH host key
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    # SSH Keys
    secrets."ssh.github.private" = {
      owner = config.users.users.kuehlein.name;
      group = config.users.users.kuehlein.group;
      mode = "0600";
      path = "/home/kuehlein/.ssh/id_ed25519_github";
    };

    secrets."ssh.github.public" = {
      owner = config.users.users.kuehlein.name;
      group = config.users.users.kuehlein.group;
      mode = "0644";
      path = "/home/kuehlein/.ssh/id_ed25519_github.pub";
    };
  };
}
