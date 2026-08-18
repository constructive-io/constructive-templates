# constructive-sso

Next.js boilerplate exercising Constructive's **cloud-function SSO**
(`functions/sso` + `functions/auth`) end-to-end with real Google OAuth.
The app signs users in through the compute sync gateway, not a GraphQL
auth server.

> **Architecture:** `fun up --k8s` brings up ONE platform database —
> `constructive-functions-db1` (in the local k8s cluster, port-forwarded to
> `:15432`). The tenant is a physical database inside that platform
> (`db-*`), provisioned with the `b2b:storage` preset. There is no second
> database and no `cnc` GraphQL server — do **not** run the old
> `docker-compose` / `cnc server` flow, it is a different, conflicting
> platform.

## Prerequisites

- Docker Desktop with Kubernetes enabled
- `pnpm`, `psql`, `kubectl`
- A sibling `constructive-db` checkout (the platform + the SSO cloud functions)
- `.env` filled with real Google credentials (see [SSO Testing](#sso-testing))

## Full setup, one step at a time

### 1. Bring up the platform (one database)

```bash
cd constructive-db/compute
fun up --k8s --alt-ports
```

This builds the functions image, starts the k8s cluster, deploys the platform
DB (`constructive-functions-db1`), registers the `functions/sso` and
`functions/auth` definitions, and starts the compute-sync gateway. ~10 min the
first time; idempotent after. Verify the four services are Ready:

```bash
kubectl get ksvc -n constructive-platform-default | grep -E 'True' 
```

### 2. Create the tenant (same database, no conflict)

```bash
cd sandbox-templates/nextjs/constructive-sso
pnpm run create-db
```

Provisions a tenant named `myapp` on the **same** platform DB via
`metaschema_public.request_database('myapp','localhost', preset_slug :=
'b2b:storage')` (warm-pool claim or cold provisioning), runs the owner
bootstrap, creates the tenant-owned `localhost` routing domain, and writes
`DATABASE_ID` plus the GraphQL-lane values (see below) back into `.env`.
Idempotent — re-running reuses the tenant.

### 3. Bind the SSO routes to the tenant on `localhost`

```bash
cd constructive-db/compute
PGHOST=localhost PGPORT=15432 PGDATABASE=constructive-functions-db1 \
  fun register --apply --route-host localhost --route-database-id "$(grep '^DATABASE_ID=' ../../sandbox-templates/nextjs/constructive-sso/.env | cut -d= -f2)"
```

Binds `/start`, `/auth/callback`, `/auth/who-am-i`, etc. to the tenant.
Expect `21 route(s) resolving on localhost`.

### 4. Add the bare-`localhost` rule to the gateway ingress

`fun up` only registers `*.localhost` / `app.localhost`; the real-Google
callback needs bare `localhost`:

```bash
kubectl patch ingress constructive-route-hosts -n constructive-platform-default --type=json \
  -p='[{"op":"add","path":"/spec/rules/-","value":{"host":"localhost","http":{"paths":[{"backend":{"service":{"name":"compute-sync-svc","port":{"number":8789}}},"path":"/","pathType":"Prefix"}]}}}]'
```

(The patch errors with "already exists" if the rule is present — that's fine;
`pnpm run local:bringup` checks for it first.)

### 5. Configure the Google provider

```bash
cd sandbox-templates/nextjs/constructive-sso
pnpm run provision
```

Upserts the `google` provider row with the endpoints from `.env`, rotates the
client secret into the tenant's encrypted store, sets the auth settings
(host-only cookie, `/login` error path), and grants the anonymous role the
sign-in lane needs.

### 6. Start the app

```bash
pnpm dev
```

The app runs on `http://localhost:3000`. Open `/login` → **Sign in with
Google** → consent → you land back on the dashboard.

> **Shortcut:** steps 2–6 are chained in one command: `pnpm run local:bringup`
> (it verifies the platform first, then runs create-db → routes → ingress →
> provision → dev).

## The two planes (SSO functions vs. GraphQL data)

The app talks to its tenant over two separate planes, both behind the same
Traefik ingress on port 80:

- **Cloud functions** (sign-in, sign-out, who-am-i): the browser calls the
  same-origin BFF (`/api/sso/*`, `/api/auth/*`), which forwards to the compute
  sync gateway on `http://localhost` with the HttpOnly session cookie as a
  Bearer credential. The credential never reaches client JS.
- **GraphQL** (orgs, members, account settings): the platform auto-provisions
  per-tenant GraphQL hosts named from the tenant's internal slug (e.g.
  `admin-208-dry-rose-fox.localhost`) — NOT from `DATABASE_NAME`. The session
  cookie is host-only on `localhost` and never crosses to those hosts, so the
  SDK's endpoints point at the same-origin proxy (`/api/graphql/{admin,auth,app}`)
  which forwards server-side. `create-db` derives the slug and writes
  `NEXT_PUBLIC_DB_NAME` / `NEXT_PUBLIC_*_ENDPOINT` / `GRAPHQL_*_URL` into
  `.env` for exactly this reason.

## SSO Testing

Put the real Google credentials in `.env` (and keep the Console redirect URI
exactly `http://localhost:3000/auth/google/callback`):

```
OAUTH_PROVIDER=google
OAUTH_CLIENT_ID=<your-google-client-id>
OAUTH_CLIENT_SECRET=<your-google-client-secret>
OAUTH_AUTHORIZE_URL=https://accounts.google.com/o/oauth2/v2/auth
OAUTH_TOKEN_URL=https://oauth2.googleapis.com/token
OAUTH_USERINFO_URL=https://openidconnect.googleapis.com/v1/userinfo
OAUTH_SCOPES=openid,email,profile
```

Then the flow is:

1. `http://localhost:3000/login` → **Sign in with Google**
2. Consent at Google → Google redirects to
   `http://localhost:3000/auth/google/callback` (the registered URI)
3. The app relays it to the gateway's page lane (`localhost/auth/callback`),
   which exchanges the code, mints the session, and sets the
   `constructive_session` cookie (host-only on `localhost`)
4. The `/auth/callback` page hydrates via `/api/auth/session` → dashboard

### After the first sign-in: promote the owner

A fresh tenant's only owner is the platform bootstrap user. The first Google
sign-in creates YOUR user, but with zero capabilities — organization creation
(and every admin surface) is RLS-gated on a capability the user doesn't have
yet (`new row violates row-level security policy for table "users"`). Run
once after your first sign-in (idempotent):

```bash
pnpm run promote-owner                    # promotes the newest human user
PROMOTE_OWNER_EMAIL=you@example.com pnpm run promote-owner   # or pick by email
```

It grants the same flags the platform's owner bootstrap does (owner/admin +
full capabilities) and fills `display_name`/`username` from the Google
profile (the generated sign-up does not populate them).

To test without Google, point the `OAUTH_*` values at the bundled mock
(`pnpm mock-oauth`, `:4010`) and rerun `pnpm run provision`.

## Re-runs / restarts

- After a Docker Desktop restart: re-run step 1 (`fun up --k8s --alt-ports`),
  then `pnpm run local:bringup`.
- To wipe the tenant and start over: `pnpm run reset-db`.

## Debugging

```bash
psql -P pager=off -h localhost -p 15432 -U postgres -d constructive-functions-db1
```

```sql
SELECT slug, left(client_id,20), authorization_url
  FROM "pool-<tenant>-auth-private".identity_providers WHERE slug='google';
SELECT id, user_id, auth_method FROM "pool-<tenant>-auth-private".sessions
  ORDER BY created_at DESC LIMIT 5;
```

(`pool-<tenant>` is the schema prefix of your tenant — find it via
`SELECT private_schema_name FROM metaschema_modules_public.identity_providers_module
WHERE database_id='<DATABASE_ID>'`.)

Gateway logs: `kubectl logs deploy/compute-sync -n constructive-platform-default`.

## Structure

| Path                          | Purpose                                                      |
| ----------------------------- | ------------------------------------------------------------ |
| `src/`                        | Next.js app (auth, account, app shell)                       |
| `src/app/api/sso/`            | BFF: `/providers`, `/start` (proxy to the cloud functions)   |
| `src/app/auth/google/callback/` | Google redirect target; relays to the gateway page lane    |
| `src/app/auth/callback/`      | session-hydration landing page                               |
| `packages/provision`          | `create-db` (tenant) / `provision` (SSO) / `promote-owner` (first-user owner grant) / `reset-db` |
| `packages/export`             | `export:graphql` (legacy GraphQL export; not used by SSO)    |
| `packages/dev-local`          | retired — CNC-era pgpm patch, not used by the cloud-function flow |
| `scripts/local-bringup.sh`    | chains create-db → routes → ingress → provision → dev        |
| `scripts/mock-oauth-server.ts`| local mock OAuth server for Google-free testing (`:4010`)    |

## Disclaimer

AS DESCRIBED IN THE LICENSES, THE SOFTWARE IS PROVIDED "AS IS", AT YOUR OWN RISK, AND WITHOUT WARRANTIES OF ANY KIND.
