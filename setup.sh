#!/bin/bash

set -euo pipefail

echo "🚀 Starting dev setup..."

# -----------------------------
# 🧠 Helpers
# -----------------------------
append_if_missing() {
  local line="$1"
  local file="$2"
  grep -qxF "$line" "$file" 2>/dev/null || echo "$line" >> "$file"
}

ensure_file() {
  local file="$1"
  [ -f "$file" ] || touch "$file"
}

ZSHRC="$HOME/.zshrc"

# -----------------------------
# 📁 Ensure .zshrc
# -----------------------------
echo "🔧 Ensuring .zshrc exists..."
ensure_file "$ZSHRC"

# -----------------------------
# 🍺 Homebrew (safe)
# -----------------------------
if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

append_if_missing 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$ZSHRC"
eval "$(/opt/homebrew/bin/brew shellenv)"

# -----------------------------
# 📦 Brew packages
# -----------------------------
if [ -f "./Brewfile.core" ]; then
  echo "📦 Installing core packages..."
  brew bundle --file=./Brewfile.core
fi

# -----------------------------
# 🧠 Oh My Zsh
# -----------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "💻 Installing Oh My Zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

append_if_missing 'export ZSH="$HOME/.oh-my-zsh"' "$ZSHRC"
append_if_missing 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' "$ZSHRC"
append_if_missing 'source $ZSH/oh-my-zsh.sh' "$ZSHRC"

# -----------------------------
# ⚡ Custom config
# -----------------------------
echo "⚡ Installing custom config..."

cp -f aliases.zsh "$HOME/aliases.zsh"
cp -f functions.zsh "$HOME/functions.zsh"

append_if_missing 'source ~/aliases.zsh' "$ZSHRC"
append_if_missing 'source ~/functions.zsh' "$ZSHRC"
append_if_missing 'export PATH="$HOME/bin:$PATH"' "$ZSHRC"

# -----------------------------
# 🔌 Plugins install (важливо!)
# -----------------------------
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# -----------------------------
# 🔧 Git config
# -----------------------------
echo "🔧 Configuring Git..."

ensure_git_config() {
  local key=$1
  local prompt=$2
  local value

  value=$(git config --global "$key" || true)

  if [ -z "$value" ]; then
    read -p "$prompt: " input
    if [ -n "$input" ]; then
      git config --global "$key" "$input"
      echo "✔ Set $key"
    else
      echo "⚠ Skipped $key"
    fi
  else
    echo "✔ $key already set ($value)"
  fi
}

ensure_git_config "user.name" "Enter your Git name"
ensure_git_config "user.email" "Enter your Git email"

# -----------------------------
# ✅ Done
# -----------------------------
echo ""
echo "✅ Setup complete!"
echo "👉 Run: source ~/.zshrc"
