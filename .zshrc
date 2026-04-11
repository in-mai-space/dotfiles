export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# Plugins to load
plugins=(you-should-use)

ZSH_THEME='robbyrussell'

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Autosuggestions
[ -f $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
[ -f $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Fast syntax highlighting
[ -f $ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ] && \
    source $ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Autocomplete
[ -f $ZSH_CUSTOM/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh ] && \
    source $ZSH_CUSTOM/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# -----------------------------
# Aliases
# -----------------------------
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# Navigation shortcuts for jumping between common folders.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'
alias dot='cd ~/dotfiles'

# Quick system inspection helpers.
alias psg='ps aux | grep -i'
alias ports='lsof -i -P -n | grep LISTEN'
alias killport='f(){ lsof -ti :$1 | xargs kill -9; }; f'

# Safer file operations with interactive prompts.
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# Better defaults for directory listings on macOS.
alias ls='ls -G'

# Network and response debugging helpers.
alias ip='curl -s https://ifconfig.me'
alias ips='echo "Local IP: $(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo unavailable)"; echo "Public IP: $(curl -s --max-time 5 https://ifconfig.me 2>/dev/null || echo unavailable)"'

# Git workflow shortcuts.
alias pus='git push'
alias pusf='git push -f'
alias reba='git rebase --abort'
alias reb='git rebase main'
alias m='git merge main'
alias ma='git merge --abort'
alias sta='git stash'
alias stap='git stash pop'
alias stac='git stash clear'
alias pul='git pull'
alias ga='git add --all'
alias gs='git status'
alias co='git commit -m'
alias cherry='git cherry-pick'
alias main='git checkout main && git pull'
alias gd='git diff --staged'
alias br='git checkout -b'
alias check='git checkout'
alias gl="git log --oneline --graph --decorate"
alias nah='git reset --hard'
alias oops='git reset --soft HEAD~1'

# Editor and shell config shortcuts.
alias c='clear'
alias v="nvim ."
alias z='nvim "$DOTFILES_DIR/.zshrc"'
alias srcz='source "$DOTFILES_DIR/.zshrc"'
alias vcfg='nvim "$DOTFILES_DIR/nvim"'

# GitHub pull request shortcuts.
alias pr="gh pr create --base main --fill"
alias list-pr="gh pr list"

if command -v go >/dev/null 2>&1; then
    export PATH="$PATH:$(go env GOPATH)/bin"
fi

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

[ -d "/opt/homebrew/opt/postgresql@15/bin" ] && export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
[ -d "/Library/TeX/texbin" ] && export PATH="/Library/TeX/texbin:$PATH"
[ -d "/opt/homebrew/opt/go@1.24/bin" ] && export PATH="/opt/homebrew/opt/go@1.24/bin:$PATH"
[ -d "/opt/homebrew/opt/go@1.22/bin" ] && export PATH="/opt/homebrew/opt/go@1.22/bin:$PATH"
