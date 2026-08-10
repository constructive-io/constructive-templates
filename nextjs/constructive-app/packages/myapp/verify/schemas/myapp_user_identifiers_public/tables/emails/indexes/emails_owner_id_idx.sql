-- Verify: schemas/myapp_user_identifiers_public/tables/emails/indexes/emails_owner_id_idx


SELECT assert_index('myapp_user_identifiers_public.emails_owner_id_idx'::regclass, 'myapp_user_identifiers_public.emails'::regclass, false);


