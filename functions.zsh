gnew() {
  git checkout -b "$1"
}

gac() {
  git add .
  git commit -m "$*"
}

greset() {
  git reset --hard
  git clean -fd
}

mkcd() {
  mkdir -p "$1" && cd "$1"
}

c() {
  cd "$@" && eza
}