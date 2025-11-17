#!/usr/bin/env bash
# Usage: ./proc_parents_gum_ps.sh <pid> [--multi]
# Works on macOS and Linux. Uses ps (no /proc) and gum for interactive SIGTERM selection.

set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Usage: $0 <pid> [--multi]"
  exit 1
fi

MULTI=false
PID_ARG="$1"
shift || true
if [ "${1:-}" = "--multi" ]; then
  MULTI=true
fi

if ! command -v gum >/dev/null 2>&1; then
  echo "Error: gum is not installed. See: https://github.com/charmbracelet/gum"
  exit 1
fi

# Check numeric PID
if ! [[ "$PID_ARG" =~ ^[0-9]+$ ]]; then
  echo "Error: PID must be a number"
  exit 1
fi

# Function: get PPID and command for a PID using ps
ps_info() {
  local pid="$1"
  ps -p "$pid" -o ppid= -o command= | awk '{ppid=$1; $1=""; sub(/^ +/,""); print ppid "\t" $0}'
}

# Verify PID exists
if ! ps -p "$PID_ARG" >/dev/null 2>&1; then
  echo "Process $PID_ARG does not exist."
  exit 1
fi

CHOICES=()
pid="$PID_ARG"
indent=""

while true; do
  line="$(ps_info "$pid" || true)"
  if [ -z "$line" ]; then
    break
  fi
  ppid="${line%%$'\t'*}"
  cmd="${line#*$'\t'}"

  CHOICES+=("$(printf "%-7s%s└─ %s" "$pid" "$indent" "${cmd:-[unknown]}")")

  if [ "$pid" -eq 1 ] || [ "$ppid" -eq 0 ]; then
    break
  fi
  pid="$ppid"
  indent="$indent  "
done

echo "Select process$( $MULTI && echo 'es' ) to SIGTERM:"

if $MULTI; then
  selected="$(printf "%s\n" "${CHOICES[@]}" | gum choose --no-limit)"
else
  selected="$(printf "%s\n" "${CHOICES[@]}" | gum choose || true)"
fi

if [ -z "${selected:-}" ]; then
  echo "No process selected. Exiting."
  exit 0
fi

# Extract PIDs manually (macOS-safe)
TARGET_PIDS=""
while IFS= read -r line; do
  pid_candidate="$(echo "$line" | awk '{print $1}')"
  if [[ "$pid_candidate" =~ ^[0-9]+$ ]]; then
    TARGET_PIDS="$TARGET_PIDS $pid_candidate"
  fi
done <<< "$selected"

TARGET_PIDS="$(echo "$TARGET_PIDS" | xargs)"  # trim whitespace

echo
if $MULTI; then
  echo "You selected: $TARGET_PIDS"
  if gum confirm "Send SIGTERM to all selected PIDs?"; then
    for tp in $TARGET_PIDS; do
      if kill -TERM "$tp" 2>/dev/null; then
        gum style --foreground 212 "Sent SIGTERM to PID $tp"
      else
        gum style --foreground 196 "Failed to SIGTERM PID $tp"
      fi
    done
  else
    echo "Cancelled."
  fi
else
  tp="$(echo "$TARGET_PIDS" | awk '{print $1}')"
  if gum confirm "Send SIGTERM to PID $tp?"; then
    if kill -TERM "$tp" 2>/dev/null; then
      gum style --foreground 212 "Sent SIGTERM to PID $tp"
    else
      gum style --foreground 196 "Failed to SIGTERM PID $tp"
    fi
  else
    echo "Cancelled."
  fi
fi
