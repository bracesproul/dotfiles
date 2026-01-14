#!/usr/bin/env bash
set -euo pipefail

########################################
# Resolve project root
# - If in a git repo, use the repo root
# - Otherwise, use the current directory
########################################
PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

########################################
# CONFIG: directories are relative to PROJECT_ROOT
########################################

DIRS=(
  "."   # deepagents langgraph dev (repo root)
  "."   # generator langgraph dev (repo root)
)

CMDS=(
  "AGENT_BUILDER_DEPLOYMENT_TYPE=deepagents uv run --with langgraph-cli langgraph dev --no-browser --port 2024 --config ./langgraph.deepagents.json"
  "AGENT_BUILDER_DEPLOYMENT_TYPE=generator uv run --with langgraph-cli langgraph dev --no-browser --port 2025 --config ./langgraph.generator.json"
)

########################################
# Do not edit below unless you know why
########################################

if [[ ${#DIRS[@]} -ne ${#CMDS[@]} ]]; then
  echo "Error: DIRS and CMDS must have the same length" >&2
  exit 1
fi

PIDS=()

cleanup() {
  echo
  echo "Shutting down all servers..."
  for pid in "${PIDS[@]}"; do
    if kill -0 "$pid" 2>/dev/null; then
      echo "Killing PID $pid"
      kill "$pid" 2>/dev/null || true
    fi
  done
  wait || true
  echo "All servers stopped."
  exit 0
}

trap cleanup INT TERM

for i in "${!DIRS[@]}"; do
  target_dir="${DIRS[$i]}"
  cmd="${CMDS[$i]}"

  # If target_dir is not absolute, make it relative to PROJECT_ROOT
  if [[ "$target_dir" != /* ]]; then
    target_dir="${PROJECT_ROOT}/${target_dir}"
  fi

  (
    cd "$target_dir"
    echo "[$(date +%T)] Starting: '$cmd' in $target_dir"
    exec bash -lc "$cmd"
  ) &

  pid=$!
  PIDS+=("$pid")
  echo "  → Started PID $pid for '$cmd'"
done

echo
echo "Project root: $PROJECT_ROOT"
echo "All servers started. PIDs: ${PIDS[*]}"
echo "Press Ctrl+C to stop them all."
wait
