-- Revert: schemas/myapp_auth_private/tables/identity_providers/grants/authenticated/delete/grant


REVOKE DELETE ON myapp_auth_private.identity_providers FROM authenticated;


