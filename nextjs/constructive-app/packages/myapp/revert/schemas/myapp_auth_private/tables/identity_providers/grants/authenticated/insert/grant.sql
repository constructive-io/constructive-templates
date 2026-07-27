-- Revert: schemas/myapp_auth_private/tables/identity_providers/grants/authenticated/insert/grant


REVOKE INSERT ON myapp_auth_private.identity_providers FROM authenticated;


