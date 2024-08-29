# .dotfiles

### Setup

1. Clone repo into `~`
```
git clone git@github.com:kuehlein/.dotfiles.git
```

2. `cd` into `.dotfiles/`
```
cd .dotfiles
```

3. Install [Homebrew](https://brew.sh/) (for macos):
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

4. Install [GNU Stow](https://www.gnu.org/software/stow/) using Homebrew:
```
brew install stow
```

5. Create symlinks:
```
stow .
```

6. Restart terminal session.

### Misc

Prevent dock from moving to second monitor (macos)
```
defaults write com.apple.dock autohide-delay -float 9999999; killall Dock
```
NOTE: if you somehow end up having the dock move to the second monitor anyway, set the delay to a much lower number, move the dock, then run this command again.

### TODO:
- a lot of stuff
- glove80 remappings included in assets/

