# Gillimac

Running these commands will extract all of the code blocks from this README to README.sh and run it to configure MacOS according to my personal preferences.

```sh
perl extract-scripts.pl > README.sh
sh README.sh
```

## TODO
- Everything terminal related [Kevin Smets](https://gist.github.com/kevin-smets/8568070), [Owen Caulfield](https://medium.com/@caulfieldOwen/youre-missing-out-on-a-better-mac-terminal-experience-d73647abf6d7)
- Don't use .bash_profile, only [.zsh files](https://zsh.sourceforge.io/Intro/intro_3.html)
- [TLDR Man Pages](https://tldr.sh/)
- .zprofile


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


## Config

## NVM
```bash
touch ~/.zshrc
touch ~/.bash_profile
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
echo "export NVM_DIR=~/.nvm" >> ~/.bash_profile
echo "source $(brew --prefix nvm)/nvm.sh" >> ~/.bash_profile
nvm use latest
```

### Terminal
```bash
# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
git clone https://github.com/asdf-vm/asdf.git ~/.oh-my-zsh/custom/plugins/asdf
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
plugins+=zsh-nvm
plugins+=asdf

echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc

# Use zshell by default
chsh -s $(which zsh)

# Increase history size
echo HISTFILESIZE=10000000 >> ~/.bash_profile

# Use `zsh-completions`
chmod -R go-w '/usr/local/share/zsh'
chmod -R go-w /usr/local/share/zsh/site-functions
chmod -R go-w /usr/local/share

echo "\nif type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi" >> ~/.zshrc
```

### ASDF (Java)
```bash
echo ". $(brew --prefix asdf)/libexec/asdf.sh" >> ~/.bash_profile
echo ". $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash" >> ~/.bash_profile
echo ". ~/.asdf/plugins/java/set-java-home.zsh" >> ~/.bash_profile


asdf plugin-add java
asdf install java openjdk-19
asdf global java openjdk-19
```

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
