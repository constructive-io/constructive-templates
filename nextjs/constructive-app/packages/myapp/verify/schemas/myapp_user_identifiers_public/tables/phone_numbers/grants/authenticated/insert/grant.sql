-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_user_identifiers_public.phone_numbers'::regclass, 'authenticated', 'INSERT', ARRAY['cc', 'number', 'owner_id', 'is_primary', 'name'], true);


