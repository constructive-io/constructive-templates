-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/triggers/timestamps_tg


SELECT assert_trigger('myapp_user_identifiers_public.phone_numbers'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


