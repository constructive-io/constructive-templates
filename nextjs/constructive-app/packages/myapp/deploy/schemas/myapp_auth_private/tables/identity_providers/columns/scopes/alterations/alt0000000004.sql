-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/scopes/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/scopes/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.scopes IS E'@has_guard
OAuth2 scopes requested in the authorization URL. For kind = ''oidc'' the admin procedure ensures ''openid'' is always present (silently prepended if missing).';

