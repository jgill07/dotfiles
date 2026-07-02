# ── Go ─────────────────────────────────────────────
# Root of Go workspace; `go install` drops binaries in $GOPATH/bin
export GOPATH=$HOME/go

# ── PATH ───────────────────────────────────────────
# `typeset -U` marks `path` as a unique array — zsh auto-drops duplicate
# entries, so re-sourcing this file never bloats PATH.
# (lowercase `path` array is tied to uppercase `$PATH` string by zsh.)
# Entries listed first take priority; $path (existing PATH) appended last.
typeset -U path
path=(
  "$HOME/.local/bin"   # pip --user, pipx, personal scripts
  "$GOPATH/bin"        # Go binaries from `go install`
  $path                # existing system PATH
)

# ── Shell functions ────────────────────────────────
# Source every *.zsh file in the functions dir.
# (N) = null_glob qualifier: yields empty list (no error) if none match —
# without it, zsh aborts with "no matches found" when the dir is empty.
for f in "$HOME/dotfiles/zsh/functions/"*.zsh(N); do
  [[ -f "$f" ]] && source "$f"
done

# ── Aliases ────────────────────────────────────────
alias tf="terraform"      # terraform
alias ddb="aws dynamodb"  # aws dynamodb subcommand

# ── Tools ──────────────────────────────────────────
# z: jump to frequently-used dirs by keyword (`z proj` → cd's there)
[[ -f $HOME/dotfiles/z/z.sh ]] && source $HOME/dotfiles/z/z.sh

# Secrets: API keys / tokens kept out of this file (and out of git).
# Guarded so shell still starts if the file is absent. chmod 600 it.
[[ -f "$HOME/.secrets.zsh" ]] && source "$HOME/.secrets.zsh"

# direnv: auto-load/unload .envrc when you cd into a project dir.
# Hook only installed if direnv is actually present.
command -v direnv >/dev/null && eval "$(direnv hook zsh)"