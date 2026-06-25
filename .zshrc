
export GOPATH=$HOME/go
export deno_path="$HOME/.deno/bin"
export PATH=$PATH:$deno_path
export PATH=$PATH:$GOPATH/bin

# Aliases
alias tf="terraform"
alias ddb="aws dynamodb"

[ -f ~/dotfiles/z/z.sh ] && source ~/dotfiles/z/z.sh

eval "$(direnv hook zsh)"