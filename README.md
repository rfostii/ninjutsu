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
bash -c "$(curl -fsSL https://raw.githubusercontent.com/rfostii/ninjutsu/main/install.sh)"
```

## 🥷 Ninjutsu CLI

Ninjutsu is a lightweight developer environment toolkit that helps you bootstrap, maintain, and diagnose your setup with a single command.

---

### 🚀 Commands

#### `ninjutsu install`

Bootstrap your entire development environment from scratch.

- Clones the repository
- Runs the full setup
- Installs the CLI globally

```bash
ninjutsu install
```

#### `ninjutsu doctor`

Diagnoses your system and automatically fixes common issues.

- Verifies shell configuration
- Ensures Git is properly configured
- Auto-fixes missing dependencies when possible

```bash
ninjutsu doctor
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

### 🌿 `gnew` — create a new branch
Create and switch to a new branch.

```bash
gnew feature/login
```

#### ⚡ `gac` — add & commit
Stages all changes and commits them with a message.

```bash
gac "fix authentication bug"
```

### 🧹 `greset` — hard reset workspace
⚠️ Dangerous command — permanently discards local changes.

```bash
greset
```

What it does:
- resets current branch to last commit
- removes untracked files and folders

### 📁 `mkcd` — create directory and enter
Creates a folder and immediately moves into it.

```bash
mkcd project-name
```

### 📂 `c` — enhanced cd with listing
Changes directory and automatically lists contents.

```bash
c ~/projects
```

Equivalent to:

```bash
cd ~/projects && eza
```

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