{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      url."ssh://git@github.com/".insteadOf = [
        "https://github.com/"
        "gh:"
        "github:"
      ];
      user = {
        email = "30834677+kuehlein@users.noreply.github.com";
        name = "Kyle Uehlein";
      };
    };
  };

  programs.ssh = {
    enable = true;
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
