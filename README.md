# Steps to configure Gillimac

## Run this README

Running these commands will extract all of the code blocks from this README to README.sh and run it.

```sh
perl extract-scripts.pl > README.sh
sh README.sh
```

## Things to add

- Everything terminal related (zsh)
- [Switch node version when .nvmrc file is found](https://stackoverflow.com/questions/23556330/run-nvm-use-automatically-every-time-theres-a-nvmrc-file-on-the-directory)
- [TLDR Man Pages](https://tldr.sh/)
- .zprofile
- Remove (replace?) VS Code settings sync, is built-in functionality now

## Homebrew

### Change ownership of necessary files / directories

```bash
sudo chown -R $(whoami) /usr/local/etc
```

### Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/gilliam/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Install all software

```bash
sudo chown -R $(whoami) /usr/local/bin /usr/local/etc /usr/local/sbin
brew bundle
```

### NVM configuration

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
touch ~/.bash_profile
echo "export NVM_DIR=~/.nvm" >> ~/.bash_profile
echo "source $(brew --prefix nvm)/nvm.sh" >> ~/.bash_profile
```

## Config

### VS Code

```bash
# Fira Code Font
curl -sL https://github.com/tonsky/FiraCode/releases/download/1.206/FiraCode_1.206.zip > FiraCode.zip
unzip FiraCode.zip -d FiraCode
mv FiraCode/ttf/* ~/Library/Fonts/
rm -rf FiraCode/ FiraCode.zip
```

### Git

```bash
git config --global user.name "Gilliam"
git config --global user.email "gi11i4m@gmail.com"

# Generate a new private / public key pair to add to GitHub, GitLab, ...
# ssh-keygen -o -t rsa -b 4096
```

### Bash

```bash
# Increase history size
echo HISTFILESIZE=10000000 >> ~/.bash_profile
```

### Terminal

```bash
# Use zshell by default
chsh -s /bin/zsh
```

## Preferences

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
m dock autohide YES
m dock magnification YES
m dock prune
```

### Keyboard

```bash
# Disable automatic capitalization
defaults write -globalDomain NSAutomaticCapitalizationEnabled 0
```

### Mouse

```bash
# Click by tapping
defaults write com.apple.AppleMultitouchTrackpad Clicking 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking 1
# Enable expose gesture
defaults write com.apple.dock showAppExposeGestureEnabled 1
```

### Finder

```bash
m finder showhiddenfiles YES
# Don't show the tags
defaults write com.apple.finder ShowRecentTags 0
# Preferred view style → three columns
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
# Location for new window → home folder
defaults write com.apple.finder NewWindowTarget PfHm
defaults write com.apple.finder NewWindowTargetPath "file:///Users/${whoami}/"
# Make Finder quitable
defaults write com.apple.finder QuitMenuItem -bool true
```

### Taskbar

```bash
# Add extra items to system menu
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu" "/System/Library/CoreServices/Menu Extras/Displays.menu" "/System/Library/CoreServices/Menu Extras/Volume.menu"
```

### Restart UI to enable changes

```bash
killall SystemUIServer
```
