#!/usr/bin/env bash
# local:bringup — reproducible cloud-function SSO bring-up, from a fresh platform.
#
# Sequence (each step re-runnable alone):
#   1. Verify the k8s platform (fun up --k8s --alt-ports) is reachable.
#   2. Provision the tenant: request_database (b2b:storage preset), owner
#      bootstrap, tenant-owned `localhost` domain, DATABASE_ID -> .env.
#   3. Bind the function routes to the tenant on `localhost`.
#   4. Add the `localhost` rule to the sync-gateway ingress.
#   5. Configure the SSO provider (real Google from OAUTH_* in .env) + the
#      anonymous grants the sign-in lane needs.
#   6. Start Next.js on :3000.
#
# The CNC GraphQL server and the mock OAuth server are NOT part of this
# bring-up: the SSO lane is served by functions/sso + functions/auth through
# the compute sync gateway (http://localhost — Traefik port 80).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
DB_REPO="${CONSTRUCTIVE_DB_DIR:-$ROOT_DIR/../../../constructive-db}"

# Load .env so every step sees the same values.
set -a
# shellcheck disable=SC1091
source "$ROOT_DIR/.env"
set +a

PGHOST="${PGHOST:-localhost}"
PGPORT="${PGPORT:-15432}"
PGDATABASE="${PGDATABASE:-constructive-functions-db1}"

echo "[1/6] Verifying the compute platform (fun up --k8s)..."
if ! psql -h "$PGHOST" -p "$PGPORT" -U "${PGUSER:-postgres}" -d "$PGDATABASE" -c 'select 1' >/dev/null 2>&1; then
  echo "  ✗ Platform Postgres not reachable on :$PGPORT — run: cd constructive-db/compute && fun up --k8s --alt-ports"
  exit 1
fi
echo "  ✓ Platform Postgres reachable"

echo "[2/6] Provisioning the tenant..."
(cd "$ROOT_DIR/packages/provision" && pnpm run create-db)
# provision-tenant rewrites DATABASE_ID in .env; reload it.
set -a
# shellcheck disable=SC1091
source "$ROOT_DIR/.env"
set +a

echo "[3/6] Binding function routes to the tenant on 'localhost'..."
if [ -z "${DATABASE_ID:-}" ]; then
  echo "  ✗ DATABASE_ID missing after provisioning"
  exit 1
fi
(cd "$DB_REPO/compute" && \
  PGHOST="$PGHOST" PGPORT="$PGPORT" PGDATABASE="$PGDATABASE" \
  fun register --apply --route-host localhost --route-database-id "$DATABASE_ID")

echo "[4/6] Adding the 'localhost' rule to the sync-gateway ingress..."
if ! kubectl get ingress constructive-route-hosts -n constructive-platform-default >/dev/null 2>&1; then
  echo "  ✗ ingress constructive-route-hosts not found — is the platform up?"
  exit 1
fi
if ! kubectl get ingress constructive-route-hosts -n constructive-platform-default -o jsonpath='{.spec.rules[*].host}' | grep -qw localhost; then
  kubectl patch ingress constructive-route-hosts -n constructive-platform-default --type=json \
    -p='[{"op":"add","path":"/spec/rules/-","value":{"host":"localhost","http":{"paths":[{"backend":{"service":{"name":"compute-sync-svc","port":{"number":8789}}},"path":"/","pathType":"Prefix"}]}}}]'
fi
echo "  ✓ localhost -> compute-sync-svc"

echo "[5/6] Configuring the SSO provider..."
(cd "$ROOT_DIR/packages/provision" && pnpm run provision)

echo "[6/6] Starting Next.js on :3000..."
cd "$ROOT_DIR"
exec pnpm dev
