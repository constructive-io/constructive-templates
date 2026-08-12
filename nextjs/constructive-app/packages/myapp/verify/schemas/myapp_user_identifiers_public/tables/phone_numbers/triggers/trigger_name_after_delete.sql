-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/triggers/trigger_name_after_delete


SELECT assert_trigger('myapp_user_identifiers_public.phone_numbers'::regclass, 'trigger_name_after_delete', 'myapp_user_identifiers_private.phone_numbers_insert_tg_ensure_primary'::regproc, 9);


