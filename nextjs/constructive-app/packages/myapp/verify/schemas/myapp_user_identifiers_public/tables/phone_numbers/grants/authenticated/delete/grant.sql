-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_user_identifiers_public.phone_numbers'::regclass, 'authenticated', 'DELETE', NULL, true);


