-- Verify: schemas/myapp_user_identifiers_public/tables/emails/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_user_identifiers_public.emails'::regclass, 'authenticated', 'DELETE', NULL, true);


