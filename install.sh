#!/bin/bash

set -euo pipefail

TMP_DIR=$(mktemp -d)

# -----------------------------
# 🎨 Colors
# -----------------------------
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

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
# ⚡ Step runner
# -----------------------------
run_step() {
  local msg=$1
  shift

  echo -ne "${BLUE}➡️  $msg...${NC}"

  "$@" > /dev/null 2>&1 &
  spinner

  if wait $!; then
    echo -e " ${GREEN}✔${NC}"
  else
    echo -e " ${RED}✖${NC}"
    exit 1
  fi
}

# -----------------------------
# 🚀 Start
# -----------------------------
echo -e "${BLUE}🥷 Ninjutsu setup starting...${NC}"
echo ""

run_step "Cloning repository" git clone https://github.com/rfostii/ninjutsu "$TMP_DIR"

cd "$TMP_DIR"

run_step "Running setup" bash setup.sh

echo ""
echo -e "${GREEN}🎉 Setup complete!${NC}"
