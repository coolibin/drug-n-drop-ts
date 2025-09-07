#!/usr/bin/env bash
set -euo pipefail

# Move to project root (one level above this script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

# Verify prerequisites
command -v node >/dev/null 2>&1 || { echo "Error: Node.js is required."; exit 1; }
command -v npm >/dev/null 2>&1 || { echo "Error: npm is required."; exit 1; }

# Ensure lite-server is installed locally (avoid npx auto-install delays)
if [ ! -x "node_modules/.bin/lite-server" ]; then
  echo "Installing dependencies..."
  if [ -f "package-lock.json" ] && [ ! -d "node_modules" ]; then
    npm ci
  else
    npm install
  fi
fi

echo "Starting lite-server..."
# Use the locally installed lite-server without allowing npx to auto-install
exec npx --no-install lite-server "$@"