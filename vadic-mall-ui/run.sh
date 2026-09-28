#!/bin/bash
set -e
cd "$(dirname "$0")"

if [ ! -d node_modules ] || [ package-lock.json -nt node_modules ]; then
  npm install
fi

# Stale .next cache can cause blank pages / "Cannot find module" 500 errors after git pull.
if [ -d .next ] && [ ! -f .next/BUILD_ID ]; then
  echo "Removing incomplete .next cache..."  
  rm -rf .next
fi

echo ""
echo "Starting Vadic Mall UI..."
echo "  Open in browser: http://localhost:4318"
echo "  (Do NOT use http://0.0.0.0:4318 — that address does not work in browsers.)"
echo ""
echo "Make sure the API is running in another terminal:"
echo "  cd ../VadicMall && ./setup.sh"
echo ""

npm run dev
