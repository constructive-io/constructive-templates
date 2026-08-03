-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/allow_link_by_email/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/allow_link_by_email/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.allow_link_by_email IS E'@has_guard
When true, an OAuth/OIDC sign-in whose IdP-verified email matches an existing user account auto-links the new identity to that account. When false, an existing-email collision raises IDENTITY_EMAIL_ALREADY_REGISTERED. Only honored when the IdP marks the email as verified.';

