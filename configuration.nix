{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.kernelModules = [ "i915" ];

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    graphics.enable = true;
  };

  networking.useDHCP = false;

  services.libinput.enable = true;
}
