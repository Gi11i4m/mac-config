# Gillimac

> Run these commands to extract all `bash` code blocks from this README to `README.sh`, then run `README.sh` to configure MacOS according to my personal preferences.

```sh
perl extract-scripts.pl > README.sh
sh README.sh
```

## Install software

### RCMD
RCMD has to be installed manually, from the [App Store](https://apps.apple.com/be/app/rcmd-app-switcher/id1596283165?mt=12)

### Homebrew

```bash
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
sudo chown -R $(whoami) /usr/local/bin /usr/local/etc /usr/local/sbin

brew bundle

# Update and upgrade Homebrew packages every 12 hours, also after login
brew trust domt4/autoupdate
brew autoupdate start 43200 --upgrade --cleanup
```

### ASDF

```bash
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add deno https://github.com/asdf-community/asdf-deno.git
asdf plugin add java https://github.com/halcyon/asdf-java.git
asdf plugin add scaleway-cli https://github.com/albarralnunez/asdf-plugin-scaleway-cli

mv .tool-versions ~/.tool-versions
asdf install
```

### Terminal

Zsh with a [Starship](https://starship.rs) prompt (pastel powerline segments; the arrows need a terminal font with Powerline glyphs, such as Fira Code below), autosuggestions, syntax highlighting, fzf, zoxide, eza and a tmux config. The dotfiles live in `dotfiles/` and are symlinked into place, so editing `~/.zshrc` etc. edits this repo. Put machine-specific shell settings in `~/.zshrc.local`, which is sourced if present and not kept in this repo.

```bash
# Use zshell by default
chsh -s $(which zsh)

# Link dotfiles
mkdir -p ~/.config
ln -sf "$PWD/dotfiles/zshrc" ~/.zshrc
ln -sf "$PWD/dotfiles/zprofile" ~/.zprofile
ln -sf "$PWD/dotfiles/tmux.conf" ~/.tmux.conf
ln -sf "$PWD/dotfiles/starship.toml" ~/.config/starship.toml

# compinit refuses group-writable completion directories
chmod go-w /opt/homebrew/share
```

### Ghostty

[Ghostty](https://ghostty.org) runs as a drop-down quick terminal on Hyper+T (top of the screen, hides when it loses focus, no Dock icon, translucent and borderless). The global hotkey needs Ghostty enabled under System Settings → Privacy & Security → Accessibility, and `macos-hidden` only takes effect after quitting Ghostty completely and starting it again.

```bash
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$GHOSTTY_DIR"
# Keep an existing config that isn't our symlink
[ -e "$GHOSTTY_DIR/config.ghostty" ] && [ ! -L "$GHOSTTY_DIR/config.ghostty" ] && mv "$GHOSTTY_DIR/config.ghostty" "$GHOSTTY_DIR/config.ghostty.bak"
ln -sf "$PWD/dotfiles/ghostty/config.ghostty" "$GHOSTTY_DIR/config.ghostty"
```

### VS Code

```bash
# Fira Code Font
curl -sL https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip > FiraCode.zip
unzip FiraCode.zip -d FiraCode
mv FiraCode/ttf/* ~/Library/Fonts/
rm -rf FiraCode/ FiraCode.zip
```

### Git

```bash
git config --global user.name "Gilliam"
git config --global user.email "gi11i4m@gmail.com"
git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.colorMoved zebra
git config --global core.editor "idea --wait"
# Show diffs through delta
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3

# Generate a new private / public key pair to add to GitHub, GitLab, ...
ssh-keygen -o -t rsa -b 4096
```

## System preferences

> Find preference domains / names like [this](https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/)

### General

```bash
# UI theme → dark mode
defaults write -globalDomain AppleInterfaceStyle "Dark"
# Disable spelling correction
defaults write -globalDomain NSAutomaticSpellingCorrectionEnabled 0
```

### Dock

```bash
m dock --autohide enable
m dock --magnification enable
m dock --prune
```

### Desktop

```bash
# Don't rearrange workspaces
defaults write com.apple.dock "mru-spaces" 0
# Disable Stage Manager
defaults write com.apple.WindowManager GloballyEnabled 0
```

### Keyboard

```bash
# Disable automatic capitalization
defaults write -globalDomain NSAutomaticCapitalizationEnabled 0
# Enable function keys by default
defaults write -globalDomain com.apple.keyboard.fnState 1 # doesn't seem to work...
```

### Mouse

```bash
# Click by tapping
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking 1
# Enable expose gesture
defaults write com.apple.dock showAppExposeGestureEnabled 1
# Increase trackpad speed
defaults write -globalDomain com.apple.trackpad.scaling 2.5
```

### Finder

```bash
m finder --showhiddenfiles enable
# Don't show the tags
defaults write com.apple.finder ShowRecentTags 0
# Preferred view style → three columns
defaults write com.apple.finder CustomViewStyle clmv
# Location for new window → home folder
defaults write com.apple.finder NewWindowTarget PfHm
defaults write com.apple.finder NewWindowTargetPath "file://$HOME/"
# Make Finder quitable
defaults write com.apple.finder QuitMenuItem -bool true
```

### Taskbar

```bash
# Add extra items to system menu
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu" "/System/Library/CoreServices/Menu Extras/Displays.menu" "/System/Library/CoreServices/Menu Extras/Volume.menu"
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" 1
```

### Restart UI to enable changes

```bash
killall SystemUIServer
```
