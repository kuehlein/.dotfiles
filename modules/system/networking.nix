{ ... }: {
  networking = {
    firewall.enable = true;
    hostName = "t490";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";
}
