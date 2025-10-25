# NixOS Configuration

*Personal NixOS configuration*

---

### Connect to new wifi network

1. Find the network:
```
$ nmcli device wifi list
```

2a. Connect to the wifi network
```
$ nmcli device wifi connect <SSID>
```

2b. Input wifi password if prompted

### Adjust volume

```
$ pactl set-sink-volume @DEFAULT_SINK@ <x>%
```


### TODO
 - disable intel ME (QM370)
 - 
 - get neovim flake working
 - easier connection to wifi

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


















### Future README section about creating ssh keys for new systems


NixOS Configuration

Set Up SSH Keys for GitHub:

For root (used for /etc/nixos):sudo -i
ssh-keygen -t ed25519 -C "kyleuehlein@gmail.com" -f /root/.ssh/id_ed25519
chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_ed25519
chmod 644 /root/.ssh/id_ed25519.pub
cat /root/.ssh/id_ed25519.pub


Copy the output and add to GitHub > Settings > SSH and GPG Keys > New SSH Key.
If copying from backup: sudo cp /path/to/backup/id_ed25519* /root/.ssh/, then set chown root:root and permissions as above.
Add to SSH agent (if passphrase-protected): ssh-add /root/.ssh/id_ed25519


Share with kuehlein (for repos like neovim-config):sudo cp /root/.ssh/id_ed25519 /home/kuehlein/.ssh/id_ed25519_github
sudo cp /root/.ssh/id_ed25519.pub /home/kuehlein/.ssh/id_ed25519_github.pub
sudo chown kuehlein:users /home/kuehlein/.ssh/id_ed25519_github*
chmod 700 /home/kuehlein/.ssh
chmod 600 /home/kuehlein/.ssh/id_ed25519_github
chmod 644 /home/kuehlein/.ssh/id_ed25519_github.pub


Configure SSH for kuehlein:echo -e "Host github.com\n  HostName github.com\n  User git\n  IdentityFile ~/.ssh/id_ed25519_github\n  IdentitiesOnly yes" > /home/kuehlein/.ssh/config
chmod 600 /home/kuehlein/.ssh/config


Ensure SSH Agent for kuehlein:echo '[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"; ssh-add ~/.ssh/id_ed25519_github' >> /home/kuehlein/.zshrc
source /home/kuehlein/.zshrc




Set Git Configuration:

Set Editor (to use Neovim instead of nano):sudo -i
git config --global core.editor "nvim"
exit
git config --global core.editor "nvim"


Set Email (to avoid GH007 privacy errors):sudo -i
cd /etc/nixos
git config --local user.email "kuehlein@users.noreply.github.com"
exit
cd ~/dev/neovim-config
git config --local user.email "kuehlein@users.noreply.github.com"
git config --global user.email "kuehlein@users.noreply.github.com"


For existing commits: git commit --amend --reset-author, then git push --force.




Switch to SSH Remote:

For /etc/nixos (root):cd /etc/nixos
git remote set-url origin git@github.com:kuehlein/your-nixos-config-repo.git


For neovim-config (kuehlein):cd ~/dev/neovim-config
git remote set-url origin git@github.com:kuehlein/neovim-config.git




Rebuild:
sudo nixos-rebuild switch --flake .


Backup Keys:

Copy /root/.ssh/id_ed25519* and /home/kuehlein/.ssh/id_ed25519_github* to an encrypted external drive.
Do not commit keys to this repository.



Using the Configuration

Root (/etc/nixos):cd /etc/nixos
git add .
git commit -m "Update config"
sudo git push
sudo nixos-rebuild switch --flake .


kuehlein (neovim-config):cd ~/dev/neovim-config
git add .
git commit -m "Update config"
git push



Troubleshooting

Permission Denied (publickey):
Root:sudo -i
ssh -vT git@github.com
ls -l /root/.ssh/id_ed25519
chmod 600 /root/.ssh/id_ed25519; chmod 644 /root/.ssh/id_ed25519.pub
cat /root/.ssh/id_ed25519.pub
ssh-add /root/.ssh/id_ed25519; ssh-add -l


kuehlein:ssh -vT git@github.com
ls -l ~/.ssh/id_ed25519_github
chmod 600 ~/.ssh/id_ed25519_github; chmod 644 ~/.ssh/id_ed25519_github.pub
cat ~/.ssh/id_ed25519_github.pub
ssh-add ~/.ssh/id_ed25519_github; ssh-add -l




Verify Remote:cd /path/to/repo
git remote -v


Should show git@github.com:kuehlein/<repo>.git.


Check SSH Config:
Root: cat /etc/ssh/ssh_config.d/200-github.conf
kuehlein: cat ~/.ssh/config


Repo Access: Visit https://github.com/kuehlein/<repo> to confirm push access.
Debug Push:cd /path/to/repo
GIT_SSH_COMMAND="ssh -v" git push


GH007 Email Error:cd /path/to/repo
git config --local user.email "kuehlein@users.noreply.github.com"
git commit --amend --reset-author
git push --force


Or uncheck "Keep my email addresses private" in GitHub > Settings > Emails.


SSH Agent Issues:eval $(ssh-agent)
ssh-add ~/.ssh/id_ed25519_github


Check: systemctl --user status ssh-agent
Ensure ~/.zshrc has: [ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"; ssh-add ~/.ssh/id_ed25519_github


Editor Issues:
Save in nano: Ctrl + O, Enter, Ctrl + X.
Set Neovim: git config --global core.editor "nvim".



Notes

Root uses /root/.ssh/id_ed25519; kuehlein uses /home/kuehlein/.ssh/id_ed25519_github (same key, different filenames).
Use kuehlein@users.noreply.github.com for commits to avoid GH007 errors.
Configurations (/root/.gitconfig, /home/kuehlein/.gitconfig, /home/kuehlein/.zshrc, SSH keys) persist through reboots/rebuilds.
Back up keys before reinstalling NixOS.
Rotate keys by updating both locations and GitHub.
