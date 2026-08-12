-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/client_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/client_id/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.client_id IS E'@has_guard
OAuth2 / OIDC client_id registered with the IdP. NULL for built-in rows until an admin sets it. Providers with NULL client_id or NULL client_secret_id are treated as not-configured by the sign-in path regardless of the enabled flag.';

