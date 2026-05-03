#!/bin/bash

set -e

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m"

fix_git_config() {
  local key=$1
  local label=$2

  if ! git config --global "$key" >/dev/null 2>&1; then
    echo -ne "${RED}✖${NC} $label → fixing... "

    read -p "$label: " value
    if [ -n "$value" ]; then
      git config --global "$key" "$value"
      echo -e "${GREEN}✔ Fixed${NC}"
    else
      echo -e "${YELLOW}⚠ Skipped${NC}"
    fi
  else
    echo -e "${GREEN}✔${NC} $label"
  fi
}

check_or_fix() {
  local name=$1
  local check_cmd=$2
  local fix_cmd=$3

  if eval "$check_cmd" >/dev/null 2>&1; then
    echo -e "${GREEN}✔${NC} $name"
  else
    echo -ne "${RED}✖${NC} $name"

    if [ -n "$fix_cmd" ]; then
      echo -ne " → fixing... "
      if eval "$fix_cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}✔ Fixed${NC}"
      else
        echo -e "${RED}✖ Failed${NC}"
      fi
    else
      echo ""
    fi
  fi
}

echo -e "${BLUE}🥷 Ninjutsu Doctor${NC}"
echo ""

fix_git_config "user.name" "Git user.name"
fix_git_config "user.email" "Git user.email"

# -----------------------------
# 📁 Files
# -----------------------------
check_or_fix ".zshrc exists" "[ -f ~/.zshrc ]" "touch ~/.zshrc"
check_or_fix "aliases.zsh exists" "[ -f ~/aliases.zsh ]" ""
check_or_fix "functions.zsh exists" "[ -f ~/functions.zsh ]" ""

echo ""
echo -e "${GREEN}✔ Doctor finished${NC}"