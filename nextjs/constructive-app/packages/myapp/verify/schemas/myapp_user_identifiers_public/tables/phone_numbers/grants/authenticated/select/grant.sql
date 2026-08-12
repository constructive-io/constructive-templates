-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_user_identifiers_public.phone_numbers'::regclass, 'authenticated', 'SELECT', NULL, true);


