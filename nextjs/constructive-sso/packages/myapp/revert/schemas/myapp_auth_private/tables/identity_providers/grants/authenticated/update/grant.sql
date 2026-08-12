-- Revert: schemas/myapp_auth_private/tables/identity_providers/grants/authenticated/update/grant


REVOKE UPDATE ON myapp_auth_private.identity_providers FROM authenticated;


