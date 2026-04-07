# Create branch
gnew() {
  git checkout -b "$1"
}

# Quick commit
gcm() {
  git add .
  git commit -m "$1"
}

# Clean repo
gclean() {
  git reset --hard
  git clean -fd
}

# mkdir + cd
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Auto ls after cd
function cd() {
  builtin cd "$@" && eza
}
