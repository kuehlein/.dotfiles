TODO:
 - a lot
 - disable intel ME (QM370)

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
