-- Verify: schemas/myapp_user_identifiers_public/tables/emails/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_user_identifiers_public.emails'::regclass, 'authenticated', 'INSERT', ARRAY['email', 'owner_id', 'is_primary', 'name'], true);


