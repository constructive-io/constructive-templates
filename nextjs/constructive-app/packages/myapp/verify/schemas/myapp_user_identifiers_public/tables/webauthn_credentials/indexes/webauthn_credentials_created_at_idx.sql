-- Verify: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/indexes/webauthn_credentials_created_at_idx


SELECT verify_index('myapp_user_identifiers_public.webauthn_credentials', 'webauthn_credentials_created_at_idx');


