# Reminder for myself

If you made an OS clean install (shame on you) this is what you need to install/configure.

The list is not complete so, for your own sake, please remember to add or fix things.

## iTerm2
Install from [here](https://www.iterm2.com/)

## Oh-my-zsh
``` sh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## Homebrew
``` sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Basic tools
``` sh
brew install cmake
brew install jq
brew install httpie
brew install fd
brew install tree
brew cask install osxfuse
brew install sshfs
```

## Docker
Install Docker from its [official page](https://www.docker.com/)

## Node JS
Install N version manager (this will also install Node LTS version)

``` sh
curl -L https://git.io/n-install | bash
```

and then install Yarn (--without-node options is mandatory)
``` sh
brew install yarn --without-node
```


## Rust
``` sh
curl https://sh.rustup.rs -sSf | sh
```

## Go
``` sh
brew install golang
```


## Dotfiles
``` sh
brew install stow
git clone https://github.com/emanuelelongo/dotfiles.git .dotfiles
cd .dotfiles
stow vim
stow git
# etc
```

## iTerm2 configuration
iTerm2 -> Preferences -> "Load preferences from custom folder or URL"
Set to "/Users/<username>/.iterm2"

## Vim and Neovim
``` sh
brew install vim
brew install neovim
pip3 install neovim
```
Make neovim uses same configuration of vim
``` sh
mkdir -p .config/nvim
ln -s .vimrc .config/nvim/init.vim
```

Let's `vim` opens __nvim__ and `vi` opens __vim__
``` sh
mkdir bin
# assuming the version are still the same
ln -s /usr/local/Cellar/neovim/0.3.1/bin/nvim vim
ln -s /usr/local/Cellar/vim/8.1.0450/bin/vim vi
```

### VimPlug
For vim
``` sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

For neovim
``` sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then from vim and neovim run:
```
:PlugInstall
```

## Instal fzf and Ag
``` sh
brew install fzf
$(brew --prefix)/opt/fzf/install
brew install ag
```

## Productivity tools

### [goseq](https://github.com/lmika/goseq) for sequence diagrams 
``` sh
go get github.com/lmika/goseq
```

