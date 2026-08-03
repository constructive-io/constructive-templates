-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/issuer_url/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/issuer_url/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.issuer_url IS E'@has_guard
OIDC issuer URL. Discovery fetches {issuer}/.well-known/openid-configuration unless discovery_url_override is set. Required when kind = ''oidc''. Used for id_token ''iss'' claim verification.';

