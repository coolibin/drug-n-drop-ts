#!/usr/bin/env bash
set -euo pipefail

# Move to project root (one level above this script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

# Verify prerequisites
command -v node >/dev/null 2>&1 || { echo "Error: Node.js is required."; exit 1; }
command -v npm >/dev/null 2>&1 || { echo "Error: npm is required."; exit 1; }

# Ensure dependencies are installed (and lite-server is available)
if [ ! -d "node_modules" ] || ! npx --no-install lite-server --version >/dev/null 2>&1; then
  echo "Installing dependencies..."
  npm install
fi

echo "Starting lite-server..."
# Use the locally installed lite-server and pass through any args
npx lite-server "$@"