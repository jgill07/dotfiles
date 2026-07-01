# safe — launch claude inside an Agent Safehouse sandbox.
#   - current dir auto-granted r/w by safehouse
#   - reads ./.safe-features (one --enable feature per line, # comments ok)
#   - reads ./.safe-env      (one env var NAME per line; value pulled from
#                             current shell and passed in via --env-pass)
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
  
  local envs=()
  if [[ -f .safe-env ]]; then
    while IFS= read -r l || [[ -n "$l" ]]; do
      l="${l%%#*}"                       # strip comment
      l="${l//[[:space:]]/}"             # strip whitespace
      [[ -n "$l" ]] && envs+=("$l")
    done < .safe-env
  fi
  local flags=()
  (( ${#feats} )) && flags+=(--enable="${(j:,:)feats}")
  (( ${#envs} ))  && flags+=(--env-pass="${(j:,:)envs}")
  $SAFEHOUSE "${flags[@]}" $CLAUDE --dangerously-skip-permissions "$@"
}