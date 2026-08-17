# constructive-templates

Boilerplate templates for Constructive applications.

## Templates

- **nextjs/constructive-app** — Next.js frontend boilerplate (email/password + org management, GraphQL SDK)
- **nextjs/constructive-sso** — Next.js boilerplate exercising cloud-function SSO (`functions/sso` + `functions/auth`) with real Google OAuth

## Quick Local Setup (nextjs/constructive-sso — cloud-function SSO)

One database only. `fun up --k8s` brings up the platform database
`constructive-functions-db1`; the tenant is created inside it. Do **not** run
the old `docker-compose` / `cnc server` flow — it is a separate, conflicting
platform.

### Local Development, step by step

**1. Bring up the platform (one database)**

```bash
cd constructive-db/compute
fun up --k8s --alt-ports
```

**2. Create the tenant on the same DB**

```bash
cd sandbox-templates/nextjs/constructive-sso
pnpm run create-db
```

**3. Bind the SSO routes on `localhost`**

```bash
cd constructive-db/compute
PGHOST=localhost PGPORT=15432 PGDATABASE=constructive-functions-db1 \
  fun register --apply --route-host localhost \
  --route-database-id "$(grep '^DATABASE_ID=' ../../sandbox-templates/nextjs/constructive-sso/.env | cut -d= -f2)"
```

**4. Add the bare-`localhost` ingress rule**

```bash
kubectl patch ingress constructive-route-hosts -n constructive-platform-default --type=json \
  -p='[{"op":"add","path":"/spec/rules/-","value":{"host":"localhost","http":{"paths":[{"backend":{"service":{"name":"compute-sync-svc","port":{"number":8789}}},"path":"/","pathType":"Prefix"}]}}}]'
```

**5. Configure Google + start the app**

```bash
cd sandbox-templates/nextjs/constructive-sso
pnpm run provision
pnpm dev
```

Then open `http://localhost:3000/login` → Sign in with Google.

**Shortcut:** steps 2–5 are chained in `pnpm run local:bringup` (it also runs
step 1's platform check). Full details and the re-run/reset/SSO-testing
instructions: [`nextjs/constructive-sso/README.md`](nextjs/constructive-sso/README.md).
