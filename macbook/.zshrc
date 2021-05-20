source $(brew --prefix nvm)/nvm.sh

# If you come from bash you might have to change your $PATH
export PATH="$HOME/bin:/usr/local/bin:/usr/local/share/npm/bin:$PATH"

# Visual studio code, open
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

alias vi="nvim"                                             # Always neovim

source /usr/local/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

export PATH="./node_modules/.bin:$PATH"    # node_modules
export PATH="$HOME/usr/local/opt/ruby/bin:$PATH"    # ruby

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"            # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export ANT_HOME=/Users/pluto/apache-ant-1.10.1
export PATH=$PATH:$ANT_HOME/bin
export PATH="$(yarn global bin)":$PATH

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

export YVM_DIR=/Users/pluto/.yvm
export PATH="/usr/local/opt/gettext/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# starfish
eval "$(starship init zsh)"
