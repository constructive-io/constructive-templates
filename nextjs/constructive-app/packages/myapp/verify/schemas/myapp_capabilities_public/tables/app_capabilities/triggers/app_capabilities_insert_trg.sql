-- Verify: schemas/myapp_capabilities_public/tables/app_capabilities/triggers/app_capabilities_insert_trg


SELECT assert_trigger('myapp_capabilities_public.app_capabilities'::regclass, 'app_capabilities_insert_trg', 'myapp_capabilities_private.app_capabilities_bitnum_tg'::regproc, 7);


