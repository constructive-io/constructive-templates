-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/grants/authenticated/update/grant


REVOKE UPDATE (name) ON myapp_user_identifiers_public.webauthn_credentials FROM authenticated;


