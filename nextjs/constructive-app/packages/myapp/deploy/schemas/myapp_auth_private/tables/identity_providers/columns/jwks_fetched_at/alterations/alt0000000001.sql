-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/jwks_fetched_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/jwks_fetched_at/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.jwks_fetched_at IS E'Timestamp of the most recent successful JWKS fetch. Used by the background refresher to age out cache entries and to drive cold-start fetches when NULL.';

