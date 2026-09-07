#!/usr/bin/env bash
# local:bringup — reproducible cloud-function SSO bring-up, from a fresh platform.
#
# Sequence (each step re-runnable alone):
#   1. Verify the k8s platform (fun up --alt-ports, KIND mode) is reachable.
#   2. Provision the tenant: request_database (b2b:storage preset), owner
#      self-membership seed (2b workaround), tenant-owned `localhost` domain,
#      DATABASE_ID -> .env.
#   3. Register the shared functions at the platform (fun register --apply
#      --as platform-bootstrap) and ensure the tenant's site + routes on
#      `localhost` (provision ensure-site: site verb + mantra install + sync
#      lanes, consuming the platform's shared images via the frame chain —
#      NO per-tenant registrations).
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

# Docker Desktop's built-in DNS (192.168.65.254) silently stops answering
# after host sleep/restarts; CoreDNS forwards there by default, so pods then
# fail EXTERNAL name resolution (OAuth token exchange dies with
# SSO_PROVIDER_TOKEN_EXCHANGE_FAILED). Re-point the forward at public DNS.
# Idempotent — no-op once patched.
if kubectl get configmap coredns -n kube-system -o jsonpath='{.data.Corefile}' 2>/dev/null | grep -q 'forward . /etc/resolv.conf'; then
  python3 - <<'PY'
import json, subprocess
cm = json.loads(subprocess.run(
    ['kubectl','get','configmap','coredns','-n','kube-system','-o','json'],
    capture_output=True, text=True).stdout)
corefile = cm['data']['Corefile'].replace(
    'forward . /etc/resolv.conf {', 'forward . 8.8.8.8 1.1.1.1 {')
print(subprocess.run(
    ['kubectl','patch','configmap','coredns','-n','kube-system','--type','merge',
     '-p', json.dumps({'data': {'Corefile': corefile}})],
    capture_output=True, text=True).stdout.strip())
PY
  kubectl rollout restart deploy/coredns -n kube-system >/dev/null 2>&1
  echo "  ✓ CoreDNS forward re-pointed to public DNS (Docker Desktop proxy guard)"
fi

echo "[2/6] Provisioning the tenant..."
(cd "$ROOT_DIR/packages/provision" && pnpm run create-db)
# provision-tenant rewrites DATABASE_ID in .env; reload it.
set -a
# shellcheck disable=SC1091
source "$ROOT_DIR/.env"
set +a

# 2b. LOCAL WORKAROUND (reported to Dan, re-verified 2026-09-01 on fd0bf6e6fdc:
#     without this seed, ensure-site fails NOT_AUTHORIZED at the site verb — the
#     machine-owned tenant's owner has no manage_sites capability). Seeds the
#     owner's own self-membership (the type-1 shape). Remove once bring-up mints
#     a proper org principal for the owning org instead.
(cd "$ROOT_DIR/packages/dev-local" && pnpm run ensure-owner-self-membership)

echo "[3/6] Registering shared functions + ensuring the tenant's site/routes on 'localhost'..."
if [ -z "${DATABASE_ID:-}" ]; then
  echo "  ✗ DATABASE_ID missing after provisioning"
  exit 1
fi
# 3a. Platform side: definitions + deployments at the platform plane.
#     --as platform-bootstrap: fun register --apply now requires an acting
#     principal (constructive-db PR #3483); fun up registers as
#     platform-bootstrap. The host-side PGHOST/PGPORT exports are how THIS
#     command reaches the platform's port-forward; register auto-detects the
#     live cluster context for its secret seeding (PR #3477 fixed the old
#     poisoning bug that made --k8s mandatory).
(cd "$DB_REPO/compute" && \
  PGHOST="$PGHOST" PGPORT="$PGPORT" PGDATABASE="$PGDATABASE" \
  fun register --apply --as platform-bootstrap)
# 3b. Tenant side: ensure the site + bind routes, CONSUMING the platform's
#     shared images through the frame chain (constructive-db PR #3475: a
#     tenant route may target any function on its own frame chain, and the
#     install verbs resolve the shared routing plane). No per-tenant function
#     registrations. Installs the mantra page set and the auth-flows/sso sync
#     lanes (who-am-i, sign-out, password verbs, start/callback).
(cd "$ROOT_DIR/packages/provision" && pnpm run ensure-site)

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
