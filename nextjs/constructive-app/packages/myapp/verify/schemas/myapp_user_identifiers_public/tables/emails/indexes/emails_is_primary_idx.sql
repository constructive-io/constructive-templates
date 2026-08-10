-- Verify: schemas/myapp_user_identifiers_public/tables/emails/indexes/emails_is_primary_idx


SELECT assert_index('myapp_user_identifiers_public.emails_is_primary_idx'::regclass, 'myapp_user_identifiers_public.emails'::regclass, true);


