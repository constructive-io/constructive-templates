-- Verify: schemas/myapp_user_identifiers_public/tables/emails/triggers/timestamps_tg


SELECT assert_trigger('myapp_user_identifiers_public.emails'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


