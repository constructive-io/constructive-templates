-- Verify: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/indexes/webauthn_credentials_owner_id_idx


SELECT assert_index('myapp_user_identifiers_public.webauthn_credentials_owner_id_idx'::regclass, 'myapp_user_identifiers_public.webauthn_credentials'::regclass, false);


