-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/table


SELECT assert_table('myapp_user_identifiers_public.phone_numbers'::regclass, false, NULL);


