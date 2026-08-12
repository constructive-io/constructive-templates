-- Verify: schemas/myapp_capabilities_public/tables/app_capability_defaults/triggers/app_capability_defaults_insert_trg


SELECT assert_trigger('myapp_capabilities_public.app_capability_defaults'::regclass, 'app_capability_defaults_insert_trg', 'utils.ensure_singleton'::regproc, 7);


