-- Verify: schemas/myapp_auth_public/tables/principals/grants/authenticated/select/grant


SELECT verify_table_grant('myapp_auth_public.principals', 'select', 'authenticated');


