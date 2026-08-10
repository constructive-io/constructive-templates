-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/triggers/trigger_name


SELECT assert_trigger('myapp_user_identifiers_public.phone_numbers'::regclass, 'trigger_name', 'myapp_user_identifiers_private.phone_numbers_insert_tg'::regproc, 7);


