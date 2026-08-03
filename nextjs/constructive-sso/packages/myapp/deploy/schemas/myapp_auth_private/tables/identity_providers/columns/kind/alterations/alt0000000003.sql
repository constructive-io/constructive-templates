-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/kind/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/kind/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.kind IS E'@has_guard
Protocol family: ''oauth2'' (manual endpoint configuration) or ''oidc'' (discovery + JWKS-verified id_token). Future kinds (''saml'') will use a different field set.';

