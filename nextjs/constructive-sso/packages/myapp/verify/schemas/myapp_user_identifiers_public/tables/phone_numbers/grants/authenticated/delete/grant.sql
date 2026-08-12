-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/grants/authenticated/delete/grant


SELECT verify_table_grant('myapp_user_identifiers_public.phone_numbers', 'DELETE', 'authenticated');


