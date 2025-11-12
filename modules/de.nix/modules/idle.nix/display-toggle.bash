#!/usr/bin/env bash
set -euo pipefail

# --------------------------
# Configuration Placeholders (will be populated by Nix)
# --------------------------
declare -A SUPPORTED_ON=()
declare -A SUPPORTED_OFF=()

@SUPPORTED_ON_DEFINITIONS@
@SUPPORTED_OFF_DEFINITIONS@

# --------------------------
# Input Validation
# --------------------------
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <on|off>" >&2
  exit 1
fi
ACTION="$1"
if [[ "$ACTION" != "on" && "$ACTION" != "off" ]]; then
  echo "Error: Parameter must be either 'on' or 'off'" >&2
  exit 1
fi

# --------------------------
# Wayland Compositor Detection (XDG Standard)
# --------------------------
if [[ "${XDG_SESSION_TYPE:-}" != "wayland" ]]; then
  echo "Error: Only Wayland sessions are supported" >&2
  exit 1
fi

RAW_DESKTOP="${XDG_CURRENT_DESKTOP:-}"
if [[ -z "$RAW_DESKTOP" ]]; then
  echo "Error: XDG_CURRENT_DESKTOP environment variable not set" >&2
  exit 1
fi

# Normalize to lowercase for case-insensitive matching
DETECTED_COMPOSITOR=$(echo "$RAW_DESKTOP" | cut -d':' -f1 | tr '[:upper:]' '[:lower:]')
echo "Detected Wayland compositor: $DETECTED_COMPOSITOR (raw: $RAW_DESKTOP)"

# Escape detected compositor name to match array keys
ESCAPED_DETECTOR=$(printf '%q' "$DETECTED_COMPOSITOR")

# --------------------------
# Command Lookup & Execution
# --------------------------
if [[ "$ACTION" == "on" ]]; then
  EXEC_CMD="${SUPPORTED_ON["$ESCAPED_DETECTOR"]}"
else
  EXEC_CMD="${SUPPORTED_OFF["$ESCAPED_DETECTOR"]}"
fi

# Execute command (eval supports complex commands: pipes, variables, quotes)
echo "Executing display ${ACTION} command: $EXEC_CMD"
eval "$EXEC_CMD"
