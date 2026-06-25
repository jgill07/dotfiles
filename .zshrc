
export GOPATH=$HOME/go
export deno_path="$HOME/.deno/bin"
export PATH=$PATH:$deno_path
export PATH=$PATH:$GOPATH/bin

# Aliases
alias tf="terraform"
alias ddb="aws dynamodb"

# Run claude.sh with safehouse
alias claude-safe="~/dotfiles/claude.sh"

[ -f ~/dotfiles/z/z.sh ] && source ~/dotfiles/z/z.sh

# Load secrets if the file exists
[ -f "$HOME/.secrets.zsh" ] && source "$HOME/.secrets.zsh"

command -v direnv >/dev/null && eval "$(direnv hook zsh)"