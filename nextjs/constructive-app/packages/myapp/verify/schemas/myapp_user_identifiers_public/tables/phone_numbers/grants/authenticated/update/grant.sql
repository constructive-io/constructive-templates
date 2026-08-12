-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_user_identifiers_public.phone_numbers'::regclass, 'authenticated', 'UPDATE', ARRAY['is_primary', 'name'], true);


