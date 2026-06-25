SAFEHOUSE="$(dirname $0)/bin/safehouse"
CLAUDE="$(which claude)"

PROFILES_DIR="$(dirname "$0")/profiles"

SAFEHOUSE="$SAFEHOUSE --enable=ssh"

eval "$SAFEHOUSE $CLAUDE --dangerously-skip-permissions $@"