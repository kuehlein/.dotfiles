# .dotfiles

### Setup

1. Clone repo into `~`
```
git clone <ssh>
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

### TODO:
a lot of stuff

