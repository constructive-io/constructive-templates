-- Verify: schemas/myapp_user_identifiers_public/tables/emails/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_user_identifiers_public.emails'::regclass, 'authenticated', 'UPDATE', ARRAY['is_primary', 'name'], true);


