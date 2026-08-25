#!/usr/bin/env bash
# local:bringup — reproducible cloud-function SSO bring-up, from a fresh platform.
#
# Sequence (each step re-runnable alone):
#   1. Verify the k8s platform (fun up --k8s --alt-ports) is reachable.
#   2. Provision the tenant: request_database (b2b:storage preset), owner
#      bootstrap, tenant-owned `localhost` domain, DATABASE_ID -> .env.
#   3. Register the shared functions at the platform (fun register --apply)
#      and bind the tenant's routes on `localhost` (provision bind-routes:
#      tenant-plane definitions + mantra page set + sso sync paths).
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

echo "[3/6] Registering shared functions + binding tenant routes on 'localhost'..."
if [ -z "${DATABASE_ID:-}" ]; then
  echo "  ✗ DATABASE_ID missing after provisioning"
  exit 1
fi
# 3a. Platform side: definitions + deployments at the platform plane. The
#     --route-database-id flag is gone from upstream — tenant-owned routes are
#     no longer written by this command (see 3b).
#     --k8s: register's env-seeding mode. Without it the mode resolves 'local',
#     `.env.k8s` (the in-cluster PG address) never loads, and the host-side
#     PGHOST/PGPORT exported below leak into the platform's seeded secrets —
#     poisoning every in-cluster workload's database connection (upstream bug
#     in fun up's seeding; see kind-migration-plan). The flag flips ONLY the
#     seeding mode; registration itself is unchanged. The host-side exports
#     stay — they are how THIS command reaches the platform's port-forward.
(cd "$DB_REPO/compute" && \
  PGHOST="$PGHOST" PGPORT="$PGPORT" PGDATABASE="$PGDATABASE" \
  fun register --apply --k8s)
# 3b. Tenant side: register the sso + mantra manifests onto the TENANT's own
#     plane (tenant-stamped definition rows — what the route-ownership guard
#     requires), then bind the tenant's routes on 'localhost': the sso sync
#     paths plus the mantra page set from the platform's route_bindings preset
#     (/auth/callback is mantra:oauth_callback's — the sso callback is not
#     routed).
(cd "$ROOT_DIR/packages/provision" && pnpm run bind-routes)

echo "[4/6] Adding the 'localhost' rule to the sync-gateway ingress..."
if ! kubectl get ingress constructive-route-hosts -n constructive-platform-default >/dev/null 2>&1; then
  echo "  ✗ ingress constructive-route-hosts not found — is the platform up?"
  exit 1
fi
# Exact host match: -w would falsely match app.localhost ('.' is a non-word
# char to grep), silently skipping the rule the whole SSO lane depends on.
if ! kubectl get ingress constructive-route-hosts -n constructive-platform-default -o jsonpath='{.spec.rules[*].host}' | tr ' ' '\n' | grep -qx 'localhost'; then
  kubectl patch ingress constructive-route-hosts -n constructive-platform-default --type=json \
    -p='[{"op":"add","path":"/spec/rules/-","value":{"host":"localhost","http":{"paths":[{"backend":{"service":{"name":"compute-sync-svc","port":{"number":8789}}},"path":"/","pathType":"Prefix"}]}}}]'
fi
echo "  ✓ localhost -> compute-sync-svc"

echo "[5/6] Configuring the SSO provider..."
(cd "$ROOT_DIR/packages/provision" && pnpm run provision)

echo "[6/6] Starting Next.js on :3000..."
cd "$ROOT_DIR"
exec pnpm dev
