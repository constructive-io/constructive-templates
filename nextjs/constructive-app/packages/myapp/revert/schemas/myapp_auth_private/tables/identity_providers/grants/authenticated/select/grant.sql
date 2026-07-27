-- Revert: schemas/myapp_auth_private/tables/identity_providers/grants/authenticated/select/grant


REVOKE SELECT (slug, kind, display_name, enabled) ON myapp_auth_private.identity_providers FROM authenticated;


