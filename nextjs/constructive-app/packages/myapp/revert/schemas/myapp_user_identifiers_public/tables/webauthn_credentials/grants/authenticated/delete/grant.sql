-- Revert: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/grants/authenticated/delete/grant


REVOKE DELETE ON myapp_user_identifiers_public.webauthn_credentials FROM authenticated;


