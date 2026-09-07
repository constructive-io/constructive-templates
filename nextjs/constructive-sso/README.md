# constructive-sso

Next.js boilerplate exercising Constructive's **cloud-function SSO** end-to-end.
Sign-in is served by the platform's shared **mantra** page set (login, sign-up,
recovery, OAuth return leg) and the **auth** sync lanes (who-am-i, sign-out),
consumed through the compute sync gateway. The app itself is just the product —
it does **not** register or fork any of the auth functions.

> **Architecture:** `fun up --alt-ports` (KIND mode) brings up ONE platform
> database — `constructive-functions-db1` (in the local kind cluster,
> port-forwarded to `:15432`). The tenant is a logical database inside that
> platform, provisioned with the `b2b:storage` preset. There is no second
> database and no `cnc` GraphQL server — do **not** run the old
> `docker-compose` / `cnc server` flow, it is a different, conflicting
> platform.

## How consumption works (no per-tenant registrations)

`functions/sso`, `functions/auth` and the `mantra` image are registered **once
at platform scope** by `fun register`. A tenant serves them by writing ordinary
rows into the shared, database-scoped routing plane (`routing_public.routes` /
`sites`) keyed by its own `database_id`. A tenant route may target any function
definition on its own **frame chain** (its own scopes, then each ancestor up to
the platform), and the install verbs resolve that shared plane along the
caller's frames — so a tenant installs mantra's page set and its sync lanes
without registering a single definition of its own. `packages/provision/
ensure-site.ts` is exactly this: a short sequence of platform verbs.

## Prerequisites

- Docker Desktop (the bring-up creates its own kind cluster — KIND mode)
- Node + `pnpm`, `psql`, `kubectl`, `kind`, `helm` on PATH
- A sibling `constructive-db` checkout (the platform + the cloud functions)
- `.env` filled with provider credentials (see [SSO Testing](#sso-testing))

## Full setup, one step at a time

### 0. (Optional) Full teardown first

Skip this on a clean machine. Run it when you want a genuinely fresh start
(stale cluster state, subnet shift after a reboot, preset experiments):

```bash
cd constructive-db
fun down                            # removes app namespaces + postgres PVC + fun state (~2-3 min, let it finish)
kind delete cluster --name constructive
kind get clusters                   # → "No kind clusters found."
```

`fun down` keeps Knative/Traefik/Cilium on purpose; the `kind delete`
removes them with the cluster — that is what a true fresh start wants.

### 1. Bring up the platform (one database)

```bash
cd constructive-db/compute
fun up --alt-ports
```

This builds the functions image, creates the kind cluster (Cilium-enforced),
deploys the platform DB (`constructive-functions-db1`), registers the shared
function definitions + deployments, and starts the compute-sync gateway.
~10–30 min the first time; idempotent after. Ends with
`K8s environment is up`.

Then re-establish the DB port-forward (fun's own forwards die with its
daemon — re-run this in any new terminal session):

```bash
nohup kubectl port-forward -n constructive-infra svc/postgres 15432:5432 >/tmp/pf.log 2>&1 &
psql -h localhost -p 15432 -U postgres -d constructive-functions-db1 -c "select 'pg-ok'"
```

### 2. Create the tenant

```bash
cd sandbox-templates/nextjs/constructive-sso
pnpm install        # once, after cloning or pulling
pnpm run create-db
```

Provisions a tenant named `myapp` on the platform DB via
`metaschema_public.request_database('myapp','localhost', preset_slug :=
'b2b:storage')` (warm-pool claim), runs the owner bootstrap, creates the
tenant-owned `localhost` routing domain, and writes `DATABASE_ID` plus the
GraphQL-lane values back into `.env`. Idempotent — re-running reuses the tenant.

### 3. Provision the rate-limiter stack (required for every NEW tenant)

`ensure-site` fails with `INVOCATION_RATE_LIMIT_NOT_PROVISIONED` without this:
upstream's `invocation_sync_verb` now hard-requires a tenant-scope
`rate_limit_meters_module`, which the `b2b:storage` warm preset does not ship
(it needs `plans_module` + `billing_module` first). One call, keyed by the
`DATABASE_ID` step 2 just wrote:

```bash
cd sandbox-templates/nextjs/constructive-sso
set -a; source .env; set +a
psql -h localhost -p 15432 -U postgres -d constructive-functions-db1 -c "
SELECT metaschema_generators.provision_database_modules(
  v_database_id := '$DATABASE_ID'::uuid,
  v_public_schema_id := (SELECT id FROM metaschema_public.schema WHERE database_id='$DATABASE_ID'::uuid AND schema_name='public'),
  v_private_schema_id := (SELECT id FROM metaschema_public.schema WHERE database_id='$DATABASE_ID'::uuid AND schema_name='private'),
  v_modules := '[\"plans_module\",\"billing_module\",\"rate_limit_meters_module\"]'::jsonb);"
```

Expected output: `{plans_module,billing_module,rate_limit_meters_module}`.
The module entries must be JSON **strings** — `{"name":...}` objects are
silently ignored. (Reported for upstream: this belongs in the preset or
`ensure-site`, not in a runbook.)

### 4. Seed the owner's capability (required for every NEW tenant)

```bash
pnpm run ensure-owner-self-membership
```

Prints `owner … self-membership ready (manage_sites in SPRT)`. Without it,
`ensure-site` fails `NOT_AUTHORIZED` at the site verb — the machine-owned
tenant's owner has no `manage_sites` capability by default.

### 5. Register the shared functions, then ensure the tenant's site + routes

```bash
cd constructive-db/compute
PGHOST=localhost PGPORT=15432 PGDATABASE=constructive-functions-db1 \
  fun register --apply --as platform-bootstrap
cd sandbox-templates/nextjs/constructive-sso
pnpm run ensure-site
```

`fun register` registers the shared images at platform scope (`--as` names the
acting principal; register auto-detects the live cluster for secret seeding).
`ensure-site` then, all as platform verbs against the shared routing plane:

- ensures the tenant's site (`sites_provision_static_site`) and durably
  verifies the `localhost` hostname (on the source `routing_public.domains`,
  never the compiled `hostname_bindings` index);
- writes the site's `canonical_url` (mantra composes the OAuth callback from it);
- installs the mantra page set (`sites_install_mantra`) plus the auth sync
  lanes (who-am-i / sign-out) and a `/_mantra/styles.css` workaround binding
  via one `install_route_bindings` custom document;
- flags the sync lanes anonymous and verifies every bound path resolves.

Expected output: `… site 'myapp' provisioned, mantra + sync lanes bound, 23
route(s) resolving on localhost`.

### 6. Add the bare-`localhost` rule to the gateway ingress

`fun up` registers `*.localhost` / `app.localhost`; the provider callback on
bare `localhost` may need an explicit rule (the route reconciler has a
localhost arm and often renders it already — this checks first):

```bash
kubectl get ingress constructive-route-hosts -n constructive-platform-default -o jsonpath='{.spec.rules[*].host}' \
  | tr ' ' '\n' | grep -qx localhost \
  || kubectl patch ingress constructive-route-hosts -n constructive-platform-default --type=json \
  -p='[{"op":"add","path":"/spec/rules/-","value":{"host":"localhost","http":{"paths":[{"backend":{"service":{"name":"compute-sync-svc","port":{"number":8789}}},"path":"/","pathType":"Prefix"}]}}}]'
```

### 7. Configure the provider

```bash
cd sandbox-templates/nextjs/constructive-sso
pnpm run provision
```

Upserts the provider row with the endpoints from `.env`, rotates the client
secret into the tenant's encrypted store, sets the auth settings (host-only
cookie, `/login` error path), and grants the anonymous role the sign-in lane
needs.

### 8. Start the app

```bash
pnpm dev
```

The app runs on `http://localhost:3000`. Signed-out, the home page shows the
provider grid; **Sign in with Google** navigates to the gateway's
`/auth/start`, mantra handles the handshake, and you land back signed in.
`/login`, `/register`, `/forgot-password`, `/reset-password` are thin redirects
to mantra's own pages on the gateway.

### Verify it works

```bash
curl -s -o /dev/null -w "%{http_code}\n" http://localhost/login     # 200 (mantra sign-in page)
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:3000/     # 200 (the app)
curl -s -o /dev/null -w "%{http_code} %{redirect_url}\n" \
  "http://localhost/auth/start?provider=google&next=%2F"
# 302 → https://accounts.google.com/… redirect_uri=http://localhost:3000/auth/callback (PKCE S256)
```

> **Shortcut:** steps 2, 3 and 4 must run once manually (the rate-limiter
> stack is not in the script yet); after that, steps 2–8 are chained by
> `pnpm run local:bringup` (it re-runs create-db idempotently, then
> membership → register + ensure-site → ingress → provision → dev).

## The two planes (auth surfaces vs. GraphQL data)

The app talks to its tenant over two separate planes, both behind the same
Traefik ingress on port 80:

- **Auth surfaces** (mantra pages + sync lanes): the browser navigates straight
  to the gateway (`http://localhost`) for mantra's pages and the OAuth start.
  The app's own origin only relays the provider's return leg
  (`/auth/callback`) and answers `/api/auth/session` + `/api/auth/sign-out`
  by forwarding the HttpOnly session cookie as a Bearer credential. The
  credential never reaches client JS. Cookies ignore port, so the host-only
  `localhost` cookie set by the gateway on `:80` is sent to the app on `:3000`.
- **GraphQL** (orgs, members, account settings): the platform auto-provisions
  per-tenant GraphQL hosts named from the tenant's internal slug (e.g.
  `admin-208-dry-rose-fox.localhost`) — NOT from `DATABASE_NAME`. The session
  cookie is host-only on `localhost` and never crosses to those hosts, so the
  SDK's endpoints point at the same-origin proxy (`/api/graphql/{admin,auth,app}`)
  which forwards server-side. `create-db` derives the slug and writes
  `NEXT_PUBLIC_DB_NAME` / `NEXT_PUBLIC_*_ENDPOINT` / `GRAPHQL_*_URL` into
  `.env` for exactly this reason.

## SSO Testing

Put the provider credentials in `.env` (and keep the Console redirect URI
exactly `http://localhost:3000/auth/callback`):

```
OAUTH_PROVIDER=google
OAUTH_CLIENT_ID=<your-google-client-id>
OAUTH_CLIENT_SECRET=<your-google-client-secret>
OAUTH_ISSUER_URL=https://accounts.google.com
OAUTH_AUTHORIZE_URL=https://accounts.google.com/o/oauth2/v2/auth
OAUTH_TOKEN_URL=https://oauth2.googleapis.com/token
OAUTH_USERINFO_URL=https://openidconnect.googleapis.com/v1/userinfo
OAUTH_SCOPES=openid,email,profile
```

Then the flow is:

1. Home page → **Sign in with Google** → the browser navigates to the
   gateway's `/auth/start?provider=google&next=/`.
2. mantra's `oauth_start` mints state + PKCE and composes the redirect URI
   from the site's `canonical_url`, then sends the browser to the provider.
3. The provider redirects to `http://localhost:3000/auth/callback` (the
   registered URI). The app relays it to the gateway's page lane
   (`localhost/auth/callback` = mantra's `oauth_callback`), which exchanges the
   code, mints the session, and sets the `constructive_session` cookie
   (host-only on `localhost`).
4. mantra 302s to `next` (`/`); the app reads the cookie via
   `/api/auth/session` → signed-in dashboard.

### Testing without Google (the mock IdP)

Point the `OAUTH_*` values at the bundled mock (`pnpm mock-oauth`, `:4010`) and
rerun `pnpm run provision`. The mock's endpoints carry its URLs and
`OAUTH_ISSUER_URL=http://localhost:4010`; it auto-consents, so the flow runs
without a Google Console. (The token/userinfo URLs may need a pod-reachable
host form of `localhost` — see the test guide.)

### After the first sign-in: promote the owner

A fresh tenant's only owner is the platform bootstrap user. The first provider
sign-in creates YOUR user, but with zero capabilities — organization creation
(and every admin surface) is RLS-gated on a capability the user doesn't have
yet. Run once after your first sign-in (idempotent):

```bash
pnpm run promote-owner                    # promotes the newest human user
PROMOTE_OWNER_EMAIL=you@example.com pnpm run promote-owner   # or pick by email
```

## Re-runs / restarts

- **Only mantra UI code changed?** No teardown needed. Rebuild the combined
  image and reload it, then hit `/login` to cold-start a fresh pod:

  ```bash
  cd constructive-db
  docker build -t constructive-functions:local -f compute/Dockerfile.dev .
  docker tag constructive-functions:local dev.local/constructive-functions:local
  kind load docker-image constructive-functions:local dev.local/constructive-functions:local --name constructive
  curl -s -o /dev/null http://localhost/login
  ```

  (fun up itself rebuilds this image, so this is only for the loop between
  bring-ups.)
- **After a computer reboot without teardown:** nodes come back Ready but all
  workload pods hang `Unknown` — that is the known Cilium stale apiserver-IP
  pin (Docker re-creates the kind bridge). Fix:
  `kubectl get nodes -o wide` for the current control-plane IP, then
  `kubectl set env ds/cilium -n kube-system KUBERNETES_SERVICE_HOST=<new-ip>`
  (same for `deploy/cilium-operator` and `ds/cilium-envoy`), force-delete the
  pods stuck in `Unknown`, and re-run the step-1 port-forward. Then
  `pnpm run local:bringup`.
- **Docker restart only, pods still Running:** just re-run the port-forward
  and `pnpm run local:bringup`.
- To wipe the tenant and start over: `pnpm run reset-db` (then re-run steps
  3–5 — the rate-limiter stack and capability seed are per-tenant).

## Debugging

```bash
psql -P pager=off -h localhost -p 15432 -U postgres -d constructive-functions-db1
```

```sql
-- the tenant's bound routes on localhost
SELECT r.path, f.task_identifier, r.config
  FROM routing_public.routes r
  LEFT JOIN catalog_private.functions f ON f.id = r.target_function_id
 WHERE r.database_id = '<DATABASE_ID>' ORDER BY r.path;

SELECT slug, left(client_id,20), authorization_url
  FROM "pool-<tenant>-auth-private".identity_providers WHERE slug='google';
```

(`pool-<tenant>` is the schema prefix of your tenant — find it via
`SELECT private_schema_name FROM metaschema_modules_public.identity_providers_module
WHERE database_id='<DATABASE_ID>'`.)

Gateway logs: `kubectl logs deploy/compute-sync -n constructive-platform-default`.

## Structure

| Path                          | Purpose                                                      |
| ----------------------------- | ------------------------------------------------------------ |
| `src/`                        | Next.js app (product, account, app shell)                    |
| `src/app/auth/callback/route.ts` | Provider redirect target; relays to the gateway page lane |
| `src/app/api/auth/session/`   | BFF: who-am-i (forwards the session cookie)                  |
| `src/app/api/auth/sign-out/`  | BFF: revoke the session                                      |
| `packages/provision`          | `create-db` (tenant) / `ensure-site` (site + routes) / `provision` (provider) / `promote-owner` / `reset-db` |
| `packages/export`             | `export:graphql` (legacy GraphQL export; not used by SSO)    |
| `scripts/local-bringup.sh`    | chains create-db → owner membership → register + ensure-site → ingress → provision → dev (run step 3's rate-limiter SQL once first) |
| `scripts/mock-oauth-server.ts`| local mock OAuth server for Google-free testing (`:4010`)    |

## Disclaimer

AS DESCRIBED IN THE LICENSES, THE SOFTWARE IS PROVIDED "AS IS", AT YOUR OWN RISK, AND WITHOUT WARRANTIES OF ANY KIND.
