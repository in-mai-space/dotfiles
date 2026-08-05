# dotfiles

bootstrap my digital self

## Setup

```sh
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://brew.sh/install.sh)"

# 2. Run bootstrap
cd ~/dotfiles
./scripts/bootstrap.sh

# 4. Authenticate GitHub
gh auth login

# 5. Install node and Claude Code
mise use --global node@lts
npm install -g @anthropic-ai/claude-code

# 6. Install nvim plugins
nvim

# 7. Reload shell
exec zsh
```

## Update

```sh
./scripts/link.sh
exec zsh
```

## Check

```sh
./scripts/check.sh
```
