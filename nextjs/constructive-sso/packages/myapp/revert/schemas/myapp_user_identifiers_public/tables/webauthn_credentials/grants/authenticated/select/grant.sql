-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/grants/authenticated/select/grant


REVOKE SELECT ON myapp_user_identifiers_public.webauthn_credentials FROM authenticated;


