#!/bin/bash

set -euo pipefail

TMP_DIR=$(mktemp -d)
INSTALL_DIR="$HOME/.ninjutsu"

# -----------------------------
# 🎨 Colors
# -----------------------------
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m"

# -----------------------------
# 🧹 Cleanup
# -----------------------------
cleanup() {
  echo ""
  echo -e "${YELLOW}🧹 Cleaning up...${NC}"
  rm -rf "$TMP_DIR"
}

trap cleanup EXIT

# -----------------------------
# 🔄 Spinner
# -----------------------------
spinner() {
  local pid=$!
  local delay=0.1
  local spinstr='|/-\'

  while kill -0 $pid 2>/dev/null; do
    printf " ${BLUE}[%c]${NC}  " "$spinstr"
    spinstr=${spinstr#?}${spinstr%${spinstr#?}}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done

  printf "      \b\b\b\b\b\b"
}

# -----------------------------
# ⚡ Step runners
# -----------------------------
run_step_bg() {
  local msg=$1
  shift

  echo -ne "${BLUE}➡️  $msg...${NC}"

  "$@" > /dev/null 2>&1 &
  spinner

  if wait $!; then
    echo -e " ${GREEN}✔${NC}"
  else
    echo -e " ${RED}✖${NC}"
    echo -e "${RED}❌ Failed: $msg${NC}"
    exit 1
  fi
}

run_step_fg() {
  local msg=$1
  shift

  echo -e "${BLUE}➡️  $msg...${NC}"

  "$@" || {
    echo -e "${RED}❌ Failed: $msg${NC}"
    exit 1
  }

  echo -e "${GREEN}✔${NC}"
}

# -----------------------------
# 🚀 Start
# -----------------------------
echo -e "${BLUE}🥷 Ninjutsu setup starting...${NC}"
echo ""

# Clone repo
run_step_bg "Cloning repository" git clone https://github.com/rfostii/ninjutsu "$TMP_DIR"

cd "$TMP_DIR"

# Prepare install dir
mkdir -p "$INSTALL_DIR"

echo -e "${BLUE}📦 Installing CLI...${NC}"

# Copy ALL relevant files (масштабовано)
cp -f ninjutsu "$INSTALL_DIR/"
cp -f *.sh "$INSTALL_DIR/"

chmod +x "$INSTALL_DIR/ninjutsu"

# Create symlink AFTER copy
if ln -sf "$INSTALL_DIR/ninjutsu" /usr/local/bin/ninjutsu 2>/dev/null; then
  echo -e "${GREEN}✔ Installed globally (/usr/local/bin)${NC}"
else
  echo -e "${YELLOW}⚠ Using ~/bin fallback${NC}"
  mkdir -p "$HOME/bin"
  ln -sf "$INSTALL_DIR/ninjutsu" "$HOME/bin/ninjutsu"

  # ensure PATH
  ZSHRC="$HOME/.zshrc"
  touch "$ZSHRC"
  grep -qxF 'export PATH="$HOME/bin:$PATH"' "$ZSHRC" || \
    echo 'export PATH="$HOME/bin:$PATH"' >> "$ZSHRC"
fi

# Run setup (interactive → foreground)
run_step_fg "Running setup" bash setup.sh

echo ""
echo -e "${GREEN}🎉 Setup complete!${NC}"
echo -e "${BLUE}👉 Try: ninjutsu doctor${NC}"
