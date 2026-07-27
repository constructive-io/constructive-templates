-- Revert: schemas/myapp_auth_public/views/identity_providers/grants/authenticated/SELECT/grant


REVOKE SELECT ON myapp_auth_public.identity_providers FROM authenticated;


