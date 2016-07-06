#! /bin/sh

# Installs Google Chrome
curl -OL https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg
open googlechrome.dmg
sudo cp -r /Volumes/Google\ Chrome/Google\ Chrome.app /Applications/

#This will run an Xcode installer as well as homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)”

# Installs Git
brew install git

# Installs emacs
brew install —with-cocoa emacs
ln -s /usr/local/bin/emacs /Applications
rm -rf ~/.emacs.d
git clone git@github.com:epxlabs/emacs-live.git ~/.emacs.d
cd ~/.emacs.d
git checkout epxlabs-master
git submodule init
git submodule update

# Show hidden files and folders in Finder
defaults write com.apple.finder AppleShowAllFiles YES
killall Finder

# Install zsh
brew install zsh
echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)”

# Install cmd line coloration for oh-my-zsh
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
# Below doesn’t work - should spend more time on it
#sed -i ‘’ ’s/plugins=(git)/plugins=(git zsh-syntax-highlighting)/g’ ~/.zshrc

# Install brew cask & iterm2
brew tap caskroom/homebrew-cask
brew install brew-cask
brew cask install iterm2


# Install Puppet 3.8.7
curl -OL https://downloads.puppetlabs.com/mac/facter-2.4.6.dmg
#curl -OL https://downloads.puppetlabs.com/mac/hiera-1.3.4.dmg
curl -OL https://downloads.puppetlabs.com/mac/puppet-3.8.7.dmg
open facter-2.4.6.dmg
#open hiera-1.3.4.dmg
open puppet-3.8.7.dmg
sudo installer -pkg /Volumes/facter-2.4.6/facter-2.4.6.pkg -target /
#sudo installer -pkg /Volumes/hiera-1.3.4/hiera-1.3.4.pkg -target /
sudo installer -pkg /Volumes/puppet-3.8.7/puppet-3.8.7.pkg -target /

# Install rbenv
brew install rbenv
rbenv init &>> ~/.zshrc
source ~/.zshrc
rbenv install 2.3.0
rbenv global 2.3.0
sudo gem install bundler

# Install Java
# Unfortunately you have to go to their site http://www.oracle.com/technetwork/java/javase/downloads/index.html

# Install leiningen
cd /usr/local/bin
curl -OL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod +x lein
lein

# Install AWS CLI
brew install awscli

# OPTIONAL: UNCOMMENT IF YOU'D LIKE TO HAVE HTOP
# brew install htop
