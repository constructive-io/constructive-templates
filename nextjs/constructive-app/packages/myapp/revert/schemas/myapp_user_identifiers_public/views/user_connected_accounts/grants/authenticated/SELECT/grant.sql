-- Revert: schemas/myapp_user_identifiers_public/views/user_connected_accounts/grants/authenticated/SELECT/grant


REVOKE SELECT ON myapp_user_identifiers_public.user_connected_accounts FROM authenticated;


