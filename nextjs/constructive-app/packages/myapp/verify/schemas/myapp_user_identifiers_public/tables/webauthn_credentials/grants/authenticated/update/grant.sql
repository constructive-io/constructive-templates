-- Verify: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_user_identifiers_public.webauthn_credentials'::regclass, 'authenticated', 'UPDATE', ARRAY['name'], true);


