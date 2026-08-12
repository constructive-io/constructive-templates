-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/triggers/phone_numbers_is_verified_monotonic_tg


SELECT assert_trigger('myapp_user_identifiers_public.phone_numbers'::regclass, 'phone_numbers_is_verified_monotonic_tg', 'utils.throw'::regproc, 19);


