-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/pkce_enabled/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/pkce_enabled/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.pkce_enabled IS E'@has_guard
When true, the auth server generates a PKCE code_verifier per authorization request, sends code_challenge with method = S256, and includes code_verifier in the token exchange. PKCE is handled entirely server-side. Default is true; only disable for IdPs that reject PKCE parameters.';

