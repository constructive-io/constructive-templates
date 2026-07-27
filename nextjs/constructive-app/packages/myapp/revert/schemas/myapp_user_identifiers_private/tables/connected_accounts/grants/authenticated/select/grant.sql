-- Revert: schemas/myapp_user_identifiers_private/tables/connected_accounts/grants/authenticated/select/grant


REVOKE SELECT ON myapp_user_identifiers_private.connected_accounts FROM authenticated;


