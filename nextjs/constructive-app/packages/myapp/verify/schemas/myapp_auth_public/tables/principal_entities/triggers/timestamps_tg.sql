-- Verify: schemas/myapp_auth_public/tables/principal_entities/triggers/timestamps_tg


SELECT assert_trigger('myapp_auth_public.principal_entities'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


