-- Verify: schemas/myapp_user_identifiers_public/tables/emails/indexes/emails_created_at_idx


SELECT assert_index('myapp_user_identifiers_public.emails_created_at_idx'::regclass, 'myapp_user_identifiers_public.emails'::regclass, false);


