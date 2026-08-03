-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/display_name/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/display_name/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.display_name IS E'Human-readable label for client UIs (e.g. ''Sign in with Google'', ''Acme Okta''). Exposed via the public-safe view.';

