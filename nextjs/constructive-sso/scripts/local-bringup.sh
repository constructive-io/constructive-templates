#!/usr/bin/env bash
# local:bringup — Deterministic end-to-end local bring-up for constructive-app.
#
# Runs the full pipeline:
#   docker compose up -> eval pgpm env -> createdb constructive ->
#   bootstrap admin -> deploy constructive-local (platform) -> create-db ->
#   provision -> deploy dev-local -> seed
#
# NOTE: 'constructive' is the ONE physical database (platform + all tenant
# schemas). 'myapp' is the logical per-tenant DB name — it is NOT a physical
# database; its schemas live inside 'constructive'.
#
# Prerequisites:
#   - Docker (for the local Postgres container)
#   - pnpm
#   - The constructive-db repo checked out as a sibling of sandbox-templates
#     (override with CONSTRUCTIVE_DB_DIR=/path/to/constructive-db)
#   - The GraphQL server running in a SEPARATE terminal (from the constructive repo).
#     SSO requires OAUTH_ENABLED=true + OAUTH_STATE_SECRET in the server's env:
#
#       source sandbox-templates/nextjs/constructive-sso/.env
#       cd constructive/graphql/server && PGDATABASE=constructive pnpm dev
#     (or, self-contained without sourcing:
#       OAUTH_ENABLED=true OAUTH_STATE_SECRET=sso-e2e-dev-state-secret-at-least-32-bytes-long \
#         PGDATABASE=constructive cnc server --port 3000 --origin "*")
#     The create-db step requires auth.localhost:3000 to respond.
#     Without OAUTH_ENABLED=true the /auth/* routes are NOT mounted (404).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

# Source .env so OAUTH_STATE_SECRET and other SSO vars are in the shell
# environment — the CNC GraphQL server reads them from process.env.
if [ -f .env ]; then
  set -a
  source .env
  set +a
fi

PLATFORM_DB="${PLATFORM_DB:-constructive}"
CONSTRUCTIVE_DB_DIR="${CONSTRUCTIVE_DB_DIR:-../../../constructive-db}"

echo ""
echo "  Constructive App — Local Bring-Up"
echo "  =================================="
echo ""

# 1. Start local Postgres container
echo "[1/8] Starting Postgres container..."
docker compose up -d

# 2. Load pgpm env vars into this shell
echo ""
echo "[2/8] Loading pgpm env..."
eval "$(pgpm env)"

# 3. Create the physical database + bootstrap admin users
echo ""
echo "[3/8] Creating database '$PLATFORM_DB' (if needed) + bootstrapping admin users..."
createdb "$PLATFORM_DB" 2>/dev/null || echo "  database '$PLATFORM_DB' already exists"
pgpm admin-users bootstrap --database "$PLATFORM_DB" --yes
pgpm admin-users add --database "$PLATFORM_DB" --test --yes

# 4. Deploy the platform (constructive-local) from the constructive-db repo
echo ""
echo "[4/8] Deploying constructive-local (platform) from $CONSTRUCTIVE_DB_DIR..."
if [ ! -d "$CONSTRUCTIVE_DB_DIR" ]; then
  echo "  !! constructive-db repo not found at $CONSTRUCTIVE_DB_DIR"
  echo "  !! Set CONSTRUCTIVE_DB_DIR=/path/to/constructive-db and re-run."
  exit 1
fi
(cd "$CONSTRUCTIVE_DB_DIR" && pgpm deploy --yes --database "$PLATFORM_DB" --package constructive-local)

# 4.5. Start mock OAuth server (for SSO testing)
echo ""
echo "[4.5/8] Starting mock OAuth server on :4010..."
# Kill any existing mock server to avoid port conflict on re-run
lsof -ti:4010 | xargs kill 2>/dev/null || true
sleep 0.5
(cd "$SCRIPT_DIR/.." && pnpm mock-oauth &)
sleep 1  # give it a moment to start

# 5. Pre-flight check: GraphQL server must be running
echo ""
echo "[5/8] Pre-flight check: GraphQL server..."
if ! curl -fsS --max-time 3 http://auth.localhost:3000/graphql \
     -H 'Content-Type: application/json' \
     -d '{"query":"{__typename}"}' > /dev/null 2>&1; then
  echo ""
  echo "  !! GraphQL server is not responding at auth.localhost:3000 !!"
  echo "  !! Run this in a separate terminal (source .env for SSO):"
  echo "  !!"
  echo "  !!   source sandbox-templates/nextjs/constructive-sso/.env"
  echo "  !!   cd constructive/graphql/server && PGDATABASE=$PLATFORM_DB pnpm dev"
  echo "  !!"
  echo "  !! (or: OAUTH_ENABLED=true PGDATABASE=$PLATFORM_DB cnc server --port 3000 --origin \"*\")"
  echo "  !!"
  echo "  !! Then re-run: pnpm run local:bringup"
  echo ""
  exit 1
fi
echo "  ✓ GraphQL server reachable"

# 5.5. Verify OAUTH_STATE_SECRET is set (needed by the server for SSO)
if [ -z "${OAUTH_STATE_SECRET:-}" ]; then
  echo "  ⚠ OAUTH_STATE_SECRET is not set — SSO will fail with OAUTH_INIT_FAILED"
  echo "  ⚠ Source .env before starting the server: source .env"
else
  echo "  ✓ OAUTH_STATE_SECRET is set"
fi

# 6. Create database (registers admin + provisions tenant modules)
echo ""
echo "[6/8] Creating database (tenant provisioning)..."
pnpm run create-db

# 7. Provision, then deploy dev-local patches
echo ""
echo "[7/8] Running provision..."
pnpm run provision

echo ""
echo "  Deploying dev-local..."
pgpm deploy --yes --database "$PLATFORM_DB" --package dev-local

# 8. Seed
echo ""
echo "[8/8] Seeding..."
pnpm run seed

echo ""
echo "  Local bring-up complete."
echo "  Next: pnpm codegen && pnpm dev"
echo ""
echo "  ⚠ SSO: The CNC server must have OAUTH_STATE_SECRET in its env."
echo "  ⚠ Start it with: source .env && cd ../../../constructive/graphql/server && PGDATABASE=constructive pnpm dev"
echo ""
