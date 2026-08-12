-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/triggers/phone_numbers_number_e164_tg


SELECT assert_trigger('myapp_user_identifiers_public.phone_numbers'::regclass, 'phone_numbers_number_e164_tg', 'myapp_user_identifiers_private.phone_numbers_number_e164_fn'::regproc, 7);


