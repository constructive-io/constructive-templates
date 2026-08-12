-- Verify: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_user_identifiers_public.webauthn_credentials'::regclass, 'authenticated', 'DELETE', NULL, true);


