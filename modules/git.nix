{ config, pkgs, ... }: {
  # TODO: swap out /home/kuehlein/... below
  environment = {
    etc = {
      # System-wide config to prefer SSH over HTTPS for Github
      "gitconfig" = {
        mode = "0444";
        text = ''
          [url "ssh://git@github.com/"]
            insteadOf = https://github.com/
        '';
      };

      # System-wide SSH config for Github
      "ssh/ssh_config.d/200-github.conf" = {
        mode = "0444";
        text = ''
          Host github.com
            HostName github.com
            User git
            IdentityFile /home/kuehlein/.ssh/id_ed25519
            IdentitiesOnly yes
        '';
      };
    };

    systemPackages = with pkgs; [ git openssh ];
  };


  programs = {
    git = {
      enable = true;
      config = {
        core = { editor = "nvim"; };
        init = { defaultBranch = "main"; };
        user = {
          email = "kuehlein@users.noreply.github.com";
          name = "Kyle Uehlein";
        };
        url = {
          "ssh://git@github.com/" = {
            insteadOf = [
              "https://github.com/"
              "gh:"
              "github:"
            ];
          };
        };
      };
    };
    ssh.startAgent = true;
  };
}
