# Dotfiles

Personal macOS development environment.

## Setup

```bash
# Install Homebrew + packages + Go tools + ZSH
./macos/install.sh
# Create symlinks to home directory
./macos/symlinks.sh
```

## Structure

- **`nvim/`** - Neovim config with LSP, Telescope, Treesitter ([detailed readme](nvim/README.md))
- **`bin/`** - 194 custom scripts (see below)
- **`zshrc`, `zsh-general.zsh`** - ZSH config with oh-my-zsh, kube-ps1, extensive aliases
- **`gitconfig`, `gitignore_global`** - Git config with delta diff viewer
- **`macos/`** - macOS setup automation and symlink creation

## Bin Scripts

| Script | Description | Category |
|--------|-------------|----------|
| [airpods.sh](bin/airpods.sh) | Display AirPods battery levels in menu bar | Utilities |
| [clone.sh](bin/clone.sh) | Clone GitHub repo to GOPATH structure | Git |
| [dir](bin/dir) | Change to parent directory of given file | Utilities |
| [docker-image](bin/docker-image) | Export Docker image filesystem to directory | Docker/Images |
| [docker-ip](bin/docker-ip) | Get IP address of Docker container | Docker/Images |
| [ff](bin/ff) | Search files by name and open in vim | Vim/Editor |
| [getpods](bin/getpods) | Display formatted pod info sorted by start time | Kubernetes |
| [git-backport](bin/git-backport) | Cherry-pick commit to release branch with PR | Git |
| [git-brr](bin/git-brr) | Interactively checkout recent branch with gum | Git |
| [git-cmp](bin/git-cmp) | Open GitHub compare page for current branch | Git |
| [git-co](bin/git-co) | Checkout branch with master/main auto-detection | Git |
| [git-fork](bin/git-fork) | Add fork remote for GitHub username | Git |
| [git-lc](bin/git-lc) | Select and edit changed files with gum | Git |
| [git-pr](bin/git-pr) | Create GitHub PR or backport to release | Git |
| [git-sh](bin/git-sh) | Show stash content by index | Git |
| [git-stt](bin/git-stt) | Select modified files for vim command | Git |
| [git-wt](bin/git-wt) | Worktree helper script | Git |
| [goplsu](bin/goplsu) | Update gopls language server | Go Development |
| [gotest](bin/gotest) | Run Go tests with reflex watch and richgo | Testing |
| [cov](bin/cov) | Interactive Go coverage viewer using gum and go-carpet | Testing |
| [covfile](bin/covfile) | Show coverage for specific file by test name | Testing |
| [covfunc](bin/covfunc) | Show coverage for specific function by test name | Testing |
| [covstats](bin/covstats) | Show coverage statistics sorted by percentage | Testing |
| [jwtd](bin/jwtd) | Decode JWT token and show expiration | Data/JSON |
| [killp.sh](bin/killp.sh) | Interactive process tree terminator using gum | Utilities |
| [ksecrets](bin/ksecrets) | Extract secret names from pod spec | Kubernetes |
| [kubectl-getall](bin/kubectl-getall) | Get all Kubernetes resources including Istio | Kubernetes |
| [kubectl-pf](bin/kubectl-pf) | Port-forward to pod by app selector | Kubernetes |
| [kubectl-sh](bin/kubectl-sh) | Execute shell in Kubernetes pod | Kubernetes |
| [pods](bin/pods) | Watch pods in tsb and istio-system | Kubernetes |
| [secrets](bin/secrets) | Extract Kubernetes secrets | Kubernetes |
| [tls-secret](bin/tls-secret) | Create TLS secret in Kubernetes | Kubernetes |
| [vii](bin/vii) | Vim wrapper script variant | Vim/Editor |
