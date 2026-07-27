-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/authorization_url/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/authorization_url/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.authorization_url IS E'OAuth2 authorization endpoint (where the user is redirected to grant consent). Required when kind = ''oauth2''; for kind = ''oidc'' resolved from cached discovery_doc.';

