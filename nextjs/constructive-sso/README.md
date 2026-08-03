# constructive-app

Next.js + Constructive per-tenant-database boilerplate with SSO testing.
Ships the base `auth:hardened` module set (email/password auth, sessions,
rate limits, passkeys, SSO infrastructure) with no org/B2B surface — see
[docs/B2B.md](./docs/B2B.md) for the org opt-in.

SSO is configured out of the box against a local mock OAuth server
(oauth2-mock-server on port 4010) — no real GitHub/Google apps needed for
development. See [SSO Testing](#sso-testing) below.

> **Architecture note:** `constructive` is the ONE physical database (platform
> + every tenant's `{tenant}_*` schemas). `myapp` is the logical per-tenant DB
> name used for schema prefixes and subdomain routing
> (`api-myapp.localhost`) — it is never a connectable database.

## Repo layout assumptions

This template expects sibling checkouts of the Constructive monorepos:

```
<workspace>/
├── constructive/        # GraphQL server + pgpm CLI (@pgpmjs/export link target)
├── constructive-db/     # platform modules (constructive-local deploy)
└── sandbox-templates/nextjs/constructive-app/   # this repo
```

`packages/export` depends on `@pgpmjs/export` via a `link:` into
`constructive/pgpm/export/dist` — build it once with
`cd constructive/pgpm/export && pnpm install && pnpm build`.

## Full setup (from scratch)

```bash
# 1. In the constructive-db repo — platform deploy
docker compose up -d
pnpm install
eval "$(pgpm env)"
createdb constructive
pgpm admin-users bootstrap --database constructive --yes
pgpm admin-users add --database constructive --test --yes
pgpm deploy --yes --database constructive --package constructive-local

# 2. In the constructive repo (constructive/graphql/server) — GraphQL server
#    SSO requires OAUTH_STATE_SECRET — source this .env first:
source sandbox-templates/nextjs/constructive-sso/.env
pnpm install
PGDATABASE=constructive pnpm dev
# (or: PGDATABASE=constructive cnc server --port 3000 --origin "*")

# 3. In this repo — create the tenant + provision modules
eval "$(pgpm env)"
pnpm run create-db
pnpm run provision
pgpm deploy --yes --database constructive --package dev-local
pnpm run seed

# 4. Generate the SDK from the live endpoints, then start the app
pnpm codegen
pnpm dev
```

Steps 1–3 (minus the GraphQL server, which runs separately) are automated by:

```bash
pnpm run local:bringup
```

## Export (regenerate packages/myapp + packages/myapp-service)

With the full setup running:

```bash
pnpm export:graphql
```

This rewrites `packages/myapp` (tenant DDL from `sql_actions`) and
`packages/myapp-service` (metaschema/services metadata). Never hand-edit the
generated SQL.

Then install the @pgpm module dependencies the proper way — `pgpm install`
inside each exported package dir (installs everything listed in the
package's `.control` `requires` into `extensions/` and records the resolved
versions in `package.json` + `.control`):

```bash
cd packages/myapp && pgpm install
cd ../myapp-service && pgpm install
```

## Redeployment (local, from exported packages)

Wipe the previous container/database first, then:

```bash
docker compose up -d
pnpm install
eval "$(pgpm env)"
createdb constructive
pgpm admin-users bootstrap --database constructive --yes
pgpm admin-users add --database constructive --test --yes

# Install @pgpm module deps (skip if extensions/ is already committed)
(cd packages/myapp-service && pgpm install)
(cd packages/myapp && pgpm install)

pgpm deploy --package myapp-service --database constructive --yes
pgpm deploy --package myapp --database constructive --yes
pgpm deploy --package dev-local --database constructive --yes
pgpm deploy --package myapp-test-seed --database constructive --yes

# GraphQL server (constructive repo): PGDATABASE=constructive pnpm dev
pnpm codegen
pnpm dev
```

## SSO Testing

This boilerplate provisions a Google-shaped identity provider pointing at a
local mock OAuth server. The full SSO flow works without real OAuth app
registrations.

### Prerequisites

1. **CNC GraphQL server** running from the `feat/oauth-reorg` (or stacked
   `feat/tenant-shared-session-sso`) branch — the OAuth middleware is mounted
   at `/auth`. **The server must have `OAUTH_STATE_SECRET` in its environment**
   — source this repo's `.env` first so the var is exported to the server
   process:
   ```bash
   source sandbox-templates/nextjs/constructive-sso/.env
   cd constructive/graphql/server
   pnpm build              # rebuild to pick up the OAuth middleware
   PGDATABASE=constructive pnpm dev
   ```
   Verify: `curl http://auth-myapp.localhost:3000/auth/providers`
   should return `{"providers":["google"]}`.

2. **OAUTH_STATE_SECRET** — set in this repo's `.env` (already has a dev value).
   The server reads it from its own `process.env`, so you MUST `source` the
   `.env` (or export it manually) before starting the server. For a fresh one:
   `openssl rand -hex 32`.

### How it works

1. `pnpm provision` calls `provisionOAuth()` which:
   - Upserts a Google identity provider pointing at the mock server (:4010)
   - Rotates the client secret via `rotate_identity_provider_app_secret`
   - Enables cookie-based SSO in `app_settings_auth`
     (`cookie_domain` empty = host-only cookie, `cookie_secure=false`)
   - Grants anonymous access to the identity_providers view (view GRANT +
     column-level GRANT + RLS policy)
   - Creates `sign_up_identity`/`sign_in_identity` wrappers in
     `{db}_auth_public` so the server's module loader resolves the tenant
     schema instead of the platform's `constructive_auth_private`

2. The **mock OAuth server** (`pnpm mock-oauth`, started by
   `local-bringup.sh` step 4.5) provides a real authorization-code + PKCE
   flow with a configurable test user.

3. The login/register pages render `AuthSocialProvidersGrid` which queries
   `identityProviders` from the auth API and builds `/auth/{slug}?redirect_uri=...`
   links pointing at the auth API origin.

4. After the OAuth callback sets the `constructive_session` cookie (host-only,
   on `auth-myapp.localhost`), the user navigates to
   `http://auth-myapp.localhost:3011/` (or `/auth/callback`). The app's
   `auth-context` runs `trySessionAuth()` on mount — a `currentUser` query
   with `credentials:'include'` that authenticates via the cookie (no Bearer
   header needed).

> IMPORTANT: the app must be accessed at `http://auth-{db}.localhost:3011`
> (same host as the auth API), NOT `localhost:3011`. The session cookie is
> host-only — `Domain=localhost` cookies are not sent to `*.localhost`
> subdomains by browsers, so the cookie would never reach the app.

### Testing the flow

```bash
# 1. Start the mock OAuth server (already in local:bringup, or run manually)
pnpm mock-oauth

# 2. Start the app
pnpm dev

# 3. Open http://auth-myapp.localhost:3011/login  (NOT localhost:3011)
#    Click "Sign in with Google" → mock OAuth server → callback → cookie set

# 4. After the callback, navigate to http://auth-myapp.localhost:3011/
#    (or http://auth-myapp.localhost:3011/auth/callback)
#    The app hydrates the session from the cookie and shows the dashboard.
```

### Using real OAuth providers

To use real GitHub or Google OAuth instead of the mock server, update the
`identity_providers` rows in the database (via SQL or by modifying
`packages/provision/src/oauth.ts`):

```sql
-- Point Google at real Google OAuth endpoints
UPDATE myapp_auth_private.identity_providers
  SET authorization_url = 'https://accounts.google.com/o/oauth2/v2/auth',
      token_url         = 'https://oauth2.googleapis.com/token',
      userinfo_url      = 'https://openidconnect.googleapis.com/v1/userinfo',
      client_id         = '<your-google-client-id>'
WHERE slug = 'google';

-- Rotate the real client secret
SELECT myapp_auth_private.rotate_identity_provider_app_secret(
  (SELECT id FROM myapp_auth_private.identity_providers WHERE slug = 'google'),
  '<your-google-client-secret>'
);
```

Real OAuth app callback URL: `http://auth-myapp.localhost:3000/auth/google/callback`

## Debugging

Use `psql -P pager=off -d constructive` so output never blocks on the pager.
The deploy steps for `myapp-service` / `myapp` are the usual failure points
after upstream changes — inspect the failing SQL there first.

Note: `pnpm codegen` runs through `scripts/codegen.sh`, which preserves this
hand-written README — the codegen tool otherwise overwrites the project-root
`README.md` with a generated SDK overview on every run.

## Structure

| Path                      | Purpose                                                      |
| ------------------------- | ------------------------------------------------------------ |
| `src/`                    | Next.js app (auth, account, app shell)                       |
| `packages/provision`      | `create-db` / `provision` / `seed` scripts                   |
| `packages/export`         | `export:graphql` — live GraphQL → pgpm packages              |
| `packages/myapp`          | exported tenant DDL package (regenerated, never hand-edited) |
| `packages/myapp-service`  | exported metaschema/services package (regenerated)           |
| `packages/myapp-test-seed`| pgpm seed package for local dev data                         |
| `packages/dev-local`      | local-dev patch module for upstream drift                    |
| `extensions/`             | @pgpm modules installed via `pgpm install`                   |
| `scripts/mock-oauth-server.ts` | local mock OAuth server (oauth2-mock-server, port 4010) |
| `src/app/auth/callback/`  | OAuth callback / session-hydration route                     |

## Disclaimer

AS DESCRIBED IN THE LICENSES, THE SOFTWARE IS PROVIDED "AS IS", AT YOUR OWN RISK, AND WITHOUT WARRANTIES OF ANY KIND.
