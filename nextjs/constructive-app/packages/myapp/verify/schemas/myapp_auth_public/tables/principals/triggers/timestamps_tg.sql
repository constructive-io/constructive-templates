-- Verify: schemas/myapp_auth_public/tables/principals/triggers/timestamps_tg


SELECT assert_trigger('myapp_auth_public.principals'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


