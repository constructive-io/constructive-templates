-- Verify: schemas/myapp_auth_public/tables/principals/table


SELECT assert_table('myapp_auth_public.principals'::regclass, false, NULL);


