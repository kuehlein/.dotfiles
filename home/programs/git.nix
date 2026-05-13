{ ... }: {
  programs.git = {
    enable = true;
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      url."ssh://git@github.com/".insteadOf = [
        "https://github.com/"
        "gh:"
        "github:"
      ];
    };
    userEmail = "30834677+kuehlein@users.noreply.github.com";
    userName = "Kyle Uehlein";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        # SSH key is managed by sops-nix and placed at this location
        # See: modules/system/secrets.nix
        identityFile = "~/.ssh/id_ed25519_github";
        identitiesOnly = true;
      };
    };
  };
}
