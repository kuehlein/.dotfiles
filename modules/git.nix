{ config, pkgs, ... }: {
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
            IdentityFile /root/.ssh/id_ed25519
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
        init = { defaultBranch = "main"; };
        url = {
          "https://github.com/" = {
            insteadOf = [ "gh:" "github:" ];
          };
        };
	user = {
	  email = "kyleuehlein@gmail.com";
	  name = "Kyle Uehlein";
	};
      };
    };
    ssh.startAgent = true;
  };

  services.ssh-agent.enable = true;
}
