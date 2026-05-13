{ pkgs, ... }: {
  users.users = {
    kuehlein = {
      description = "kuehlein - admin";
      extraGroups = [
        "audio"          # Access to audio devices (e.g., sound cards).
        "docker"         # If using Docker, for container management.
        "input"          # For input devices if needed.
        "libvirtd"       # If using virtualization like QEMU/KVM.
        "networkmanager" # Allows managing networks without root.
        "video"          # Access to video devices (e.g., webcams, GPUs).
        "wheel"          # Enables sudo access.
      ];
      isNormalUser = true;
      shell = pkgs.zsh;
    };
  };

  programs.zsh.enable = true;
}
