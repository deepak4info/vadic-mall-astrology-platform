#!/bin/bash
# =============================================================================
# Vadic Mall - Reset & Seed Database (SQLite)
# =============================================================================
# IMPORTANT:
#   vadicmall.db is a BINARY SQLite file — do NOT open it in TextEdit/VS Code
#   as plain text. Use DB Browser for SQLite, or read database/seed-data.sql
#
# This script:
#   1. Deletes the old database
#   2. Starts the API briefly (EF Core creates tables + seeds demo data)
#   3. Stops the API when ready
#
# Usage (from project root or VadicMall folder):
#   chmod +x scripts/reset-and-seed.sh
#   ./scripts/reset-and-seed.sh
#
# Demo logins after seed:
#   admin@vadicmall.com      / Admin@123
#   customer@vadicmall.com   / Customer@123
#   pandit.sharma@vadicmall.com / Astro@123
# =============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
API_DIR="$SCRIPT_DIR/../src/VadicMall.Api"
DB_FILE="$API_DIR/vadicmall.db"

export PATH="$HOME/.dotnet:$PATH"

if ! command -v dotnet >/dev/null 2>&1; then
  echo "ERROR: .NET 8 SDK not found. Install from https://dotnet.microsoft.com/download/dotnet/8.0"
  exit 1
fi

echo "Removing old database..."
rm -f "$DB_FILE" "$DB_FILE-shm" "$DB_FILE-wal"

echo "Building API..."
dotnet build "$SCRIPT_DIR/../VadicMall.sln" -c Release -v q

echo "Creating database and seeding data (this may take 15-30 seconds)..."
cd "$API_DIR"

dotnet run -c Release --urls "http://127.0.0.1:5080" --no-build &
API_PID=$!

cleanup() {
  kill "$API_PID" 2>/dev/null || true
  wait "$API_PID" 2>/dev/null || true
}
trap cleanup EXIT

for i in $(seq 1 60); do
  if curl -sf "http://127.0.0.1:5080/api/health" >/dev/null 2>&1; then
    echo ""
    echo "Database ready!"
    echo "  Location : $DB_FILE"
    echo "  Size     : $(du -h "$DB_FILE" | cut -f1)"
    echo ""
    echo "View readable seed SQL : $SCRIPT_DIR/../database/seed-data.sql"
    echo "Browse data (macOS)    : open with DB Browser for SQLite"
    echo ""
    echo "Start API normally     : cd VadicMall && ./setup.sh"
    exit 0
  fi
  sleep 1
done

echo "ERROR: API did not start in time. Check dotnet run output above."
exit 1
