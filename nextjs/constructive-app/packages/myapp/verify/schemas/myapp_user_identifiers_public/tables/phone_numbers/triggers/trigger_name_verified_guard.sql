-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/triggers/trigger_name_verified_guard


SELECT assert_trigger('myapp_user_identifiers_public.phone_numbers'::regclass, 'trigger_name_verified_guard', 'myapp_user_identifiers_private.phone_numbers_insert_tg_verified_guard'::regproc, 19);


