-- Verify: schemas/myapp_user_identifiers_public/tables/emails/triggers/trigger_name_verified_guard


SELECT assert_trigger('myapp_user_identifiers_public.emails'::regclass, 'trigger_name_verified_guard', 'myapp_user_identifiers_private.emails_insert_tg_verified_guard'::regproc, 19);


