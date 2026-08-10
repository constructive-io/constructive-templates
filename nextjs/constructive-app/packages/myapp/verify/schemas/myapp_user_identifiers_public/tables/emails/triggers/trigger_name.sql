-- Verify: schemas/myapp_user_identifiers_public/tables/emails/triggers/trigger_name


SELECT assert_trigger('myapp_user_identifiers_public.emails'::regclass, 'trigger_name', 'myapp_user_identifiers_private.emails_insert_tg'::regproc, 7);


