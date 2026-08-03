-- Deploy: schemas/myapp_auth_private/tables/identity_providers/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table


COMMENT ON TABLE myapp_auth_private.identity_providers IS E'@has_guard
OAuth2 / OIDC (and future SAML) identity provider definitions per database. Holds endpoint URLs, encrypted client secret reference, scopes, audience validation list, PKCE setting, and email-handling flags. Cached OIDC discovery_doc + JWKS are refreshed by background jobs. All writes go through SECURITY DEFINER admin procedures.';

