-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/skip_nonce_check/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/skip_nonce_check/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.skip_nonce_check IS E'OIDC only. When true, the auth server does not require / verify the ''nonce'' claim in id_token. ONLY enable for IdPs that demonstrably do not support nonce; weakens replay resistance.';

