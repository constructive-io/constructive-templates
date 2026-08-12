-- Verify: schemas/myapp_user_identifiers_public/tables/emails/triggers/trigger_name_after_delete


SELECT assert_trigger('myapp_user_identifiers_public.emails'::regclass, 'trigger_name_after_delete', 'myapp_user_identifiers_private.emails_insert_tg_ensure_primary'::regproc, 9);


