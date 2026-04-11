# 🥷 Ninjutsu

_Those who break the rules are scum... but those who abandon automation are worse._

> Personal macOS dev setup — fast, clean, reproducible.

---

## ⚡ What is this?

**Ninjutsu** is my personal dotfiles setup for quickly bootstrapping a macOS development environment that will make you an IT ninja.

One command → and you get:
- a configured shell
- essential tools installed
- Git aliases ready
- Node.js + pnpm set up

---

## 🚀 Quick Start

```bash
git clone <your-repo>
cd Ninjutsu
chmod +x setup.sh
./setup.sh
```

## Examples

```bash
gnew feature/login   # create & switch branch
gcm "fix bug"        # add + commit
mkcd project         # create folder + cd
```

## ⚡ Aliases & Functions

This setup includes a set of aliases and shell functions designed to speed up common workflows.

---

### 🧠 Git Aliases (Oh My Zsh)

Provided by the `git` plugin:

| Alias | Command | Description |
|------|--------|-------------|
| `gs` | `git status` | Show repository status |
| `gc` | `git commit` | Create commit |
| `gco` | `git checkout` | Switch branch |
| `gp` | `git push` | Push changes |
| `gl` | `git pull` | Pull changes |
| `gcm` | `git checkout main` | Checkout main branch |

---

### ⚡ Custom Aliases

| Alias | Command | Description |
|------|--------|-------------|
| `ll` | `eza -la` | List files (detailed) |
| `ls` | `eza` | Better `ls` |
| `proj` | `cd ~/projects` | Go to projects folder |
| `nr` | `npm run` | Run npm script |
| `ni` | `npm install` | Install dependencies |
| `pi` | `pnpm install` | Install with pnpm |
| `pr` | `pnpm run` | Run pnpm script |

---

### 🔥 Custom Functions

#### `gnew`
Create and switch to a new branch.

```bash
gnew feature/login

---

## 🚀 Daily Workflow

Typical development flows using this setup.

---

```bash
# 🌿 Create a new feature
gnew feature/auth

# ✍️ Make changes and commit
gac "add login validation"

# ⬆️ Push to remote
gp

# 🔄 Sync with remote
gl

# 🧹 Clean repository (dangerous)
gclean
```