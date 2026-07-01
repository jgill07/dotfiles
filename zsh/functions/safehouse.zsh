# safe — launch claude inside an Agent Safehouse sandbox.
#   - current dir auto-granted r/w by safehouse
#   - reads ./.safe-features (one --enable feature per line, # comments ok)
#   - forwards args to claude (e.g. `safe --resume <id>`)

SAFEHOUSE="$HOME/dotfiles/bin/safehouse"
CLAUDE="$(which claude)"

safe() {
  local feats=()
  if [[ -f .safe-features ]]; then
    while IFS= read -r l || [[ -n "$l" ]]; do
      l="${l%%#*}"                       # strip comment
      l="${l//[[:space:]]/}"             # strip whitespace
      [[ -n "$l" ]] && feats+=("$l")
    done < .safe-features
  fi
  local flags=()
  (( ${#feats} )) && flags=(--enable="${(j:,:)feats}")
  $SAFEHOUSE "${flags[@]}" $CLAUDE --dangerously-skip-permissions "$@"
}