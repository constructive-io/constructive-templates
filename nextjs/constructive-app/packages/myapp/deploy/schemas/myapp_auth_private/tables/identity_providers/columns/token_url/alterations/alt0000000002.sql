-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/token_url/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/token_url/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.token_url IS E'@has_guard
OAuth2 token endpoint (exchanges authorization code for access/id tokens). Required when kind = ''oauth2''; for kind = ''oidc'' resolved from cached discovery_doc.';

