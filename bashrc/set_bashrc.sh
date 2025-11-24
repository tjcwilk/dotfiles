#!/usr/bin/env bash
set -euo pipefail

# set_bashrc.sh
# Runs reset_bashrc.sh then update_bashrc.sh (both in the same directory)

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -f "$DIR/reset_bashrc.sh" ]]; then
  if [[ -x "$DIR/reset_bashrc.sh" ]]; then
    "$DIR/reset_bashrc.sh"
  else
    echo "Note: $DIR/reset_bashrc.sh exists but is not executable. Running with bash." >&2
    bash "$DIR/reset_bashrc.sh"
  fi
else
  echo "Warning: $DIR/reset_bashrc.sh not found." >&2
fi

if [[ -f "$DIR/update_bashrc.sh" ]]; then
  if [[ -x "$DIR/update_bashrc.sh" ]]; then
    "$DIR/update_bashrc.sh"
  else
    echo "Note: $DIR/update_bashrc.sh exists but is not executable. Running with bash." >&2
    bash "$DIR/update_bashrc.sh"
  fi
else
  echo "Warning: $DIR/update_bashrc.sh not found." >&2
fi

echo "Completed: reset then update run from $DIR"
