-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/grants/authenticated/select/grant


SELECT verify_table_grant('myapp_user_identifiers_public.phone_numbers', 'select', 'authenticated');


