-- Verify: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


SELECT assert_table('myapp_user_identifiers_public.webauthn_credentials'::regclass, false, NULL);


