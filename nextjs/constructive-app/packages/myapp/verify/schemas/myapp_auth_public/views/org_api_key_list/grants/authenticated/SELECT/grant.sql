-- Verify: schemas/myapp_auth_public/views/org_api_key_list/grants/authenticated/SELECT/grant


SELECT assert_table_grant('myapp_auth_public.org_api_key_list'::regclass, 'authenticated', 'SELECT', NULL, true);


