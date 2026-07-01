
export GOPATH=$HOME/go
export deno_path="$HOME/.deno/bin"
export PATH="$PATH:$HOME/.local/bin:$deno_path"
export PATH=$PATH:$GOPATH/bin


# Source functions
for f in "$HOME/dotfiles/zsh/functions/"*.zsh; do
  [ -f "$f" ] && source "$f"
done

# Aliases
alias tf="terraform"
alias ddb="aws dynamodb"

[ -f ~/dotfiles/z/z.sh ] && source ~/dotfiles/z/z.sh

# Load secrets if the file exists
[ -f "$HOME/.secrets.zsh" ] && source "$HOME/.secrets.zsh"

command -v direnv >/dev/null && eval "$(direnv hook zsh)"