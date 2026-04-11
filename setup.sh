#!/bin/bash

set -e

echo "🚀 Starting dev setup..."

# -----------------------------------
# 🍺 Homebrew
# -----------------------------------
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# -----------------------------------
# 📦 Packages
# -----------------------------------
echo "Installing packages from Brewfile..."
echo "Select what to install:"
echo "1) Core only"
echo "2) Core + Apps"
read -p "Enter choice [1-2]: " choice

case $choice in
  1)
    brew bundle --file=./Brewfile.core
    ;;
  2)
    brew bundle --file=./Brewfile.core
    brew bundle --file=./Brewfile.apps
    ;;
  *)
    echo "Invalid choice"
    ;;
esac

# -----------------------------------
# 🔗 Symlinks
# -----------------------------------
echo "Linking config files..."

ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/aliases.zsh ~/aliases.zsh
ln -sf $(pwd)/functions.zsh ~/functions.zsh

# -----------------------------------
# ⚡ Install Oh My Zsh
# -----------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# -----------------------------------
# 🔌 Zsh plugins
# -----------------------------------
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# -----------------------------------
# 🧠 Git aliases
# -----------------------------------
echo "Setting git aliases..."

git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm commit
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.undo "reset --soft HEAD~1"
git config --global alias.amend "commit --amend --no-edit"

# -----------------------------------
# 🟢 NVM install
# -----------------------------------
if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load nvm
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

# Install latest LTS Node
nvm install --lts
nvm use --lts

# -----------------------------------
# 📦 pnpm
# -----------------------------------
echo "Installing pnpm..."
npm install -g pnpm

echo "✅ Setup complete!"
echo "👉 Restart terminal or run: source ~/.zshrc"
