-- Verify: schemas/myapp_auth_public/tables/principals/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_auth_public.principals'::regclass, 'authenticated', 'SELECT', NULL, true);


