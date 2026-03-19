# Gillimac

> Run these commands to extract all `bash` code blocks from this README to `README.sh`, then run `README.sh` to configure MacOS according to my personal preferences.

```sh
perl extract-scripts.pl > README.sh
sh README.sh
```

## TODO

- [ ] Everything terminal related [Kevin Smets](https://gist.github.com/kevin-smets/8568070), [Owen Caulfield](https://medium.com/@caulfieldOwen/youre-missing-out-on-a-better-mac-terminal-experience-d73647abf6d7)
- [ ] Don't use .bash_profile, only [.zsh files](https://zsh.sourceforge.io/Intro/intro_3.html)
- [ ] .zprofile
- [ ] Use ASDF instead of NVM
- [ ] Add [Homebrew Autoupdate](https://github.com/DomT4/homebrew-autoupdate) instructions


## Install software

### RCMD
RCMD has to be installed manually, from the [App Store](https://apps.apple.com/be/app/rcmd-app-switcher/id1596283165?mt=12)

### Homebrew

```bash
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
sudo chown -R $(whoami) /usr/local/bin /usr/local/etc /usr/local/sbin

brew bundle

echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/gilliamflebus/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/gilliamflebus/.zprofile
```

### ASDF

```bash
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add deno https://github.com/asdf-community/asdf-deno.git
asdf plugin add java https://github.com/halcyon/asdf-java.git

mv .tool-versions ~/.tool-versions
asdf install
```

### Terminal

```todo
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
echo HISTFILESIZE=10000000 >> ~/.zprofile

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
defaults write com.apple.finder NewWindowTargetPath "file:///Users/${whoami}/"
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
